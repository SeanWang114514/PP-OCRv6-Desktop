# PP-OCRv6 Desktop（原生 C++）

离线 OCR + 中英翻译的 Windows 桌面工具。原生 Win32 C++ x64 程序，不依赖 Python、
PySide 或 PaddleOCR 运行时。OCR 引擎为 PP-OCRv6 Tiny 的 ncnn C++ 推理实现（ncnn
20241226 + OpenCV 4.11 静态库），翻译由内嵌的 MTranServer 在本机完成。

## 下载最新版

最新版可执行文件（ChineseOCRLiteDesktop.exe，单文件、自包含、无需安装）发布在 **GitHub Releases**：

- 打开本仓库的 **Releases** 页面，下载最新 ChineseOCRLiteDesktop.exe；
- exe 内置了 OCR 模型、字典和翻译引擎，直接双击运行即可；
- 首次运行会向 %LOCALAPPDATA%\PP-OCRv6 Desktop\ 释放内置资源。

> exe 约 250MB，超过 GitHub 仓库单文件 100MB 上限，因此源码进仓库、exe 作为 Release 附件发布。

## 功能

- 全局快捷键（默认 Ctrl + Alt + S，可在设置窗口改）一键截图识别；
- 截图后拖动选区，自动异步 OCR（PP-OCRv6 Tiny 检测 + 识别 + 方向分类）；
- 识别结果弹窗：
  - 原文可编辑、可缩放；
  - 「删除空格」「删除换行」快速清理 OCR 文本（换行合并为空格）；
  - 「翻译」调用内置 MTranServer（可选 中文/英文，源语言自动）；
  - 「复制原文」「复制译文」；
- 托盘常驻：关闭主窗口最小化到托盘，双击托盘图标恢复；
- 开机自启动（可选）、启动后隐藏到托盘（可选）；
- 记住主窗口 / 设置窗口 / 结果窗口的大小与位置；
- 后台空闲内存优化：隐藏到托盘或空闲 60 秒时自动释放工作集，识别/翻译期间不打断。

## 使用

运行 exe 后按 Ctrl + Alt + S（或点「截图并识别」），框选屏幕区域，松手即识别。需要翻译时在结果弹窗点「翻译」。

## 从源码构建（Windows x64，MSVC）

前置条件：Visual Studio 2022（MSVC + CMake 支持）。仓库内已包含 third_party（ncnn 20241226 与 OpenCV 4.11 静态库）。

```bat
build_native.bat
```

CMake 构建后会把 models 与 ppocrv6_config.json 复制到产物目录。

> 说明：translation_assets\ 下的 mtranserver.exe 与 mtran 模型（约 1.1GB）体积过大，
> 未纳入 git（已由 exe 内置）。若需从源码重新生成完整自包含 exe，请将本地
> translation_assets\mtranserver.exe、mtran_models\、mtran_config\ 恢复后重新编译。

## 自检

```bat
ChineseOCRLiteDesktop.exe --selftest
```

退出码 0 表示 OCR 模型加载与中英翻译均正常。

## 当前模型

- 检测：PP_OCRv6_tiny_det
- 识别：PP_OCRv6_tiny_rec
- 方向分类：PP_LCNet_x0_25_textline_ori
- 字典：ppocr_keys_v6.txt

## 已完成验证

```text
CMake + MSVC x64 Release 构建：PASS
--selftest（OCR 模型加载 + 英→中 / 中→英翻译）：PASS（exit 0）
GUI 保活测试：PASS
```

## 来源与许可

PP-OCRv6 ncnn C++ 推理集成参考 [Avafly/PaddleOCR-ncnn-CPP](https://github.com/Avafly/PaddleOCR-ncnn-CPP)，
PP-OCR 模型由 [PaddleOCR](https://github.com/PaddlePaddle/PaddleOCR) 提供，ncnn 来自
[Tencent/ncnn](https://github.com/Tencent/ncnn)。再分发时请保留相应上游许可证。
