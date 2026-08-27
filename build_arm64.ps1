# build_arm64.ps1 — 交叉编译 ARM64 版 ChineseOCRLiteDesktop
# 前置条件:
#   - VS2022 BuildTools 含 ARM64 工具链 (Microsoft.VisualStudio.Component.VC.Tools.ARM64)
#   - 磁盘剩余 > 10GB (D 盘)
# 产物: out-arm64\Release\ChineseOCRLiteDesktop.exe (ARM64, 单文件自包含全部模型)
# 依赖库 (本地编译, 不提交 git):
#   third_party/ncnn-arm64   (ncnn master, /MT)
#   third_party/opencv-arm64 (OpenCV 4.11.0, core+imgproc+imgcodecs, NEON, /MT)

$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Root
$Src = "$Root\third_party-src"

# ---------- 1. 获取源码 (仅缺失时克隆) ----------
New-Item -ItemType Directory -Force -Path $Src | Out-Null
if (-not (Test-Path "$Src\opencv\CMakeLists.txt")) {
    git clone --depth 1 --branch 4.11.0 https://github.com/opencv/opencv.git "$Src\opencv"
    if ($LASTEXITCODE -ne 0) { throw 'OpenCV 源码克隆失败' }
}
if (-not (Test-Path "$Src\ncnn\CMakeLists.txt")) {
    git clone --depth 1 https://github.com/Tencent/ncnn.git "$Src\ncnn"
    if ($LASTEXITCODE -ne 0) { throw 'ncnn 源码克隆失败' }
}

# ---------- 2. 编译 ncnn ARM64 (/MT) ----------
Write-Host '[1/3] 编译 ncnn ARM64 ...'
cmake -S "$Src\ncnn" -B "$Root\out-arm64-ncnn-mt" -G "Visual Studio 17 2022" -A ARM64 `
    -DCMAKE_BUILD_TYPE=Release -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded `
    -DNCNN_BUILD_TOOLS=OFF -DNCNN_BUILD_EXAMPLES=OFF -DNCNN_BUILD_TESTS=OFF `
    -DNCNN_BUILD_BENCHMARK=OFF -DNCNN_VULKAN=OFF -DNCNN_OPENMP=ON `
    -DCMAKE_INSTALL_PREFIX="$Root\third_party\ncnn-arm64"
if ($LASTEXITCODE -ne 0) { throw 'ncnn configure 失败' }
cmake --build "$Root\out-arm64-ncnn-mt" --config Release --parallel 14
if ($LASTEXITCODE -ne 0) { throw 'ncnn 编译失败' }
cmake --install "$Root\out-arm64-ncnn-mt" --config Release

# ---------- 3. 编译 OpenCV ARM64 (core+imgproc+imgcodecs, NEON, /MT) ----------
Write-Host '[2/3] 编译 OpenCV ARM64 (约 30-60 分钟) ...'
cmake -S "$Src\opencv" -B "$Root\out-arm64-opencv" -G "Visual Studio 17 2022" -A ARM64 `
    -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF "-DBUILD_LIST=core,imgproc,imgcodecs" `
    -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_EXAMPLES=OFF -DBUILD_opencv_apps=OFF `
    -DBUILD_opencv_js=OFF -DBUILD_opencv_python3=OFF -DBUILD_PROTOBUF=OFF `
    -DWITH_IPP=OFF -DWITH_OPENCL=OFF -DWITH_MSMF=OFF -DWITH_FFMPEG=OFF `
    -DWITH_JASPER=OFF -DWITH_OPENJPEG=OFF -DWITH_QUIRC=OFF -DWITH_WEBP=OFF -DWITH_TIFF=OFF `
    -DWITH_ADE=OFF "-DCPU_BASELINE=NEON" "-DCPU_DISPATCH=" `
    -DCMAKE_INSTALL_PREFIX="$Root\third_party\opencv-arm64" `
    -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded
if ($LASTEXITCODE -ne 0) { throw 'OpenCV configure 失败' }
cmake --build "$Root\out-arm64-opencv" --config Release --parallel 14
if ($LASTEXITCODE -ne 0) { throw 'OpenCV 编译失败' }
cmake --install "$Root\out-arm64-opencv" --config Release

# ---------- 4. 编译主程序 ARM64 ----------
Write-Host '[3/3] 编译主程序 ARM64 ...'
Remove-Item -Recurse -Force "$Root\out-arm64" -ErrorAction SilentlyContinue
cmake -S $Root -B "$Root\out-arm64" -G "Visual Studio 17 2022" -A ARM64
if ($LASTEXITCODE -ne 0) { throw '主程序 configure 失败' }
cmake --build "$Root\out-arm64" --config Release --parallel 14
if ($LASTEXITCODE -ne 0) { throw '主程序编译失败' }

# ---------- 5. 验证 + 部署 ----------
$exe = "$Root\out-arm64\Release\ChineseOCRLiteDesktop.exe"
$b = [System.IO.File]::ReadAllBytes($exe)
$pe = [BitConverter]::ToInt32($b, 0x3C)
$m = [BitConverter]::ToUInt16($b, $pe + 4)
if ($m -ne 0xAA64) { throw "产物不是 ARM64! machine=0x{0:X}" -f $m }
New-Item -ItemType Directory -Force -Path "$Root\native-dist-arm64" | Out-Null
Copy-Item $exe "$Root\native-dist-arm64\ChineseOCRLiteDesktop.exe" -Force
Write-Host "完成: native-dist-arm64\ChineseOCRLiteDesktop.exe ($([math]::Round($b.Length/1MB)) MB, ARM64)"
