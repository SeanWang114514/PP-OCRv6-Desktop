# 结果弹窗验证：模拟完整 OCR 流程（热键->拖选->识别->结果窗口）
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Text;
public class W32T {
    [DllImport("user32.dll")] public static extern bool SetProcessDPIAware();
    public delegate bool EnumProc(IntPtr hWnd, IntPtr lParam);
    [DllImport("user32.dll")] public static extern bool EnumWindows(EnumProc cb, IntPtr lParam);
    [DllImport("user32.dll")] public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint pid);
    [DllImport("user32.dll")] public static extern int GetClassName(IntPtr hWnd, StringBuilder sb, int max);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int cmd);
    [DllImport("user32.dll")] public static extern bool SetWindowPos(IntPtr hWnd, IntPtr after, int x, int y, int cx, int cy, uint flags);
    [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr hWnd, out RECT r);
    [DllImport("user32.dll")] public static extern bool PrintWindow(IntPtr hWnd, IntPtr hdc, uint flags);
    [DllImport("user32.dll")] public static extern bool PostMessage(IntPtr hWnd, uint msg, IntPtr wParam, IntPtr lParam);
    [StructLayout(LayoutKind.Sequential)] public struct RECT { public int Left, Top, Right, Bottom; }
    public static IntPtr FindByClass(uint pid, string cls) {
        IntPtr found = IntPtr.Zero;
        EnumWindows(delegate(IntPtr h, IntPtr lp) {
            uint wpid; GetWindowThreadProcessId(h, out wpid);
            if (wpid == pid) {
                StringBuilder sb = new StringBuilder(128);
                GetClassName(h, sb, 128);
                if (sb.ToString() == cls) { found = h; return false; }
            }
            return true;
        }, IntPtr.Zero);
        return found;
    }
    public static RECT GetRect(IntPtr h) { RECT r; GetWindowRect(h, out r); return r; }
    public static bool Print(IntPtr h, IntPtr hdc) { return PrintWindow(h, hdc, 2); }
}
"@
[W32T]::SetProcessDPIAware() | Out-Null
function Cap($h, $path) {
    $r = [W32T]::GetRect($h); $w = $r.Right-$r.Left; $hh = $r.Bottom-$r.Top
    $bmp = New-Object System.Drawing.Bitmap($w, $hh)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $hdc = $g.GetHdc(); $ok = [W32T]::Print($h, $hdc); $g.ReleaseHdc($hdc)
    if ($ok) { $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png) }
    $g.Dispose(); $bmp.Dispose(); return $ok
}
$p = Start-Process -FilePath 'D:\VibeCoding\ocr工具\native-dist\ChineseOCRLiteDesktop.exe' -PassThru
Start-Sleep -Seconds 5
$p.Refresh(); if ($p.HasExited) { Write-Output "EXITED $($p.ExitCode)"; exit 1 }
$pidU = [uint32]$p.Id
$h = [W32T]::FindByClass($pidU, 'ChineseOCRLiteDesktop')
if ($h -eq [IntPtr]::Zero) { Write-Output 'NO MAIN'; exit 1 }
[W32T]::ShowWindow($h, 9) | Out-Null
[W32T]::SetWindowPos($h, [IntPtr]::Zero, 30, 30, 0, 0, 0x0001) | Out-Null
Start-Sleep -Milliseconds 400
$r0 = [W32T]::GetRect($h)
Write-Output "main: $($r0.Right-$r0.Left)x$($r0.Bottom-$r0.Top)"
Cap $h 'C:\Users\ADMINI~1\AppData\Local\Temp\ocr_main_500.png'
# 触发截图（等同点击"截图并识别"按钮）
[W32T]::PostMessage($h, 0x0111, [IntPtr]1002, [IntPtr]::Zero) | Out-Null
Start-Sleep -Seconds 1
$ov = [W32T]::FindByClass($pidU, 'ChineseOCRLiteOverlay')
if ($ov -eq [IntPtr]::Zero) { Write-Output 'NO OVERLAY'; Stop-Process -Id $p.Id -Force; exit 1 }
Write-Output 'overlay opened'
# 模拟鼠标拖选区域 (200,200)-(700,450)
[W32T]::PostMessage($ov, 0x0201, [IntPtr]1, [IntPtr](200 -bor (200 -shl 16))) | Out-Null  # WM_LBUTTONDOWN
[W32T]::PostMessage($ov, 0x0200, [IntPtr]1, [IntPtr](700 -bor (450 -shl 16))) | Out-Null  # WM_MOUSEMOVE
[W32T]::PostMessage($ov, 0x0202, [IntPtr]0, [IntPtr](700 -bor (450 -shl 16))) | Out-Null  # WM_LBUTTONUP
Write-Output 'selection posted, waiting OCR...'
# 等待结果窗口出现（OCR 引擎首次加载可能较慢）
$rh = [IntPtr]::Zero
for ($i = 0; $i -lt 60; $i++) {
    Start-Sleep -Milliseconds 500
    $rh = [W32T]::FindByClass($pidU, 'ChineseOCRLiteResult')
    if ($rh -ne [IntPtr]::Zero) { break }
}
if ($rh -eq [IntPtr]::Zero) { Write-Output 'NO RESULT WINDOW after 30s'; Stop-Process -Id $p.Id -Force; exit 1 }
Start-Sleep -Milliseconds 600
$rr = [W32T]::GetRect($rh)
Write-Output "result window: $($rr.Right-$rr.Left)x$($rr.Bottom-$rr.Top)"
$ok = Cap $rh 'C:\Users\ADMINI~1\AppData\Local\Temp\ocr_result.png'
Write-Output "result captured=$ok"
$p.Refresh()
Write-Output "WORKING_SET_MB=$([math]::Round($p.WorkingSet64/1MB,1))"
Stop-Process -Id $p.Id -Force
Write-Output 'DONE'
