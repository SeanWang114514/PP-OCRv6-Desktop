# PP-OCRv6 native C++/ncnn migration research

Workspace: D:\VibeCoding\ocr工具

## Result

A self-contained PP-OCRv6 ncnn implementation is feasible, but the primary app was not modified. The verified reference is Avafly/PaddleOCR-ncnn-CPP release v0.3.0, which explicitly adds PP-OCRv6 tiny/small/medium support and documents ncnn 20241226, OpenCV 4.11.0, and OpenMP 2.0+.

Sources:
- https://github.com/Avafly/PaddleOCR-ncnn-CPP
- https://github.com/Avafly/PaddleOCR-ncnn-CPP/releases/tag/v0.3.0
- https://github.com/Tencent/ncnn/releases/tag/20241226

## Isolated verification

The v0.3.0 archive was downloaded and built separately at C:/PaddleOCR-release/tree/PaddleOCR-ncnn-CPP with the existing static OpenCV 4.11.0 and ncnn tag 20241226. The upstream sample ran full det + cls + rec on ocr_img1.png and printed Hello OCR! and :D with exit 0. This was a real end-to-end inference test, not just model loading.

ncnn 20210720 was also tested and crashed on the PP-OCRv6 sample, so it must not be used. Verified ncnn commit: 528589571085b673be7313a9c6e65801f150f607 (tag 20241226).

## Recommended tiny assets

- PP_OCRv6_tiny_det.param / .bin
- PP_OCRv6_tiny_rec.param / .bin
- PP_LCNet_x0_25_textline_ori.param / .bin
- ppocr_keys_v6_tiny.txt

The archive also contains small and medium variants, plus ppocr_keys_v6.txt for small/medium. Exact verified tiny SHA-256 values are recorded below:

- PP_OCRv6_tiny_det.param: 3b30a15fe238b94c81b5e0871a31cde087524189bad16121296c8dd8844195b1
- PP_OCRv6_tiny_det.bin: 28103390d3e626b80d15778789163206db50cfac3e2dbed0426d7f133a89fd5e
- PP_OCRv6_tiny_rec.param: d1122af82f33f030a98275f8bac3104432c51f20823b2544580e8d3a1c951772
- PP_OCRv6_tiny_rec.bin: 72cf0935134b3d9e75e9ad234b5bd2ec48f09a9ce4f9c84e50130db2edb2011d
- PP_LCNet_x0_25_textline_ori.param: 118ffa2ddd396622a50006ae9191332a07ff5e8145d046448ed88eddf5210c54
- PP_LCNet_x0_25_textline_ori.bin: b62e900da8bacb5b8d9655f73fcb5aff618ca532e4c7a3568ff795bfbfd0d2a7
- ppocr_keys_v6_tiny.txt: 3e699cc868c6d8f0a33f29258f0370ee5fff3c60a4e5cb0a9edc7e938b86cf3f

All assets are under models/ in the v0.3.0 archive.

## Integration steps

1. Keep the current GUI untouched while validating a separate PP-OCRv6 engine target.
2. Port or wrap the upstream reference sources: db_net.cpp, angle_net.cpp, crnn_net.cpp, ocr_engine.cpp, utils.cpp, and Clipper2 files.
3. Use ncnn tag 20241226 built /MT CPU-only first; reuse the existing OpenCV 4.11.0.
4. Put tiny assets under native-dist/models/ppocrv6_tiny/ and copy that directory beside the EXE at build time.
5. Initialize with det, cls, and rec model paths plus ppocr_keys_v6_tiny.txt. Use the new engine's input/output names and preprocessing; do not reuse chineseocr_lite code or model names.
6. Start with fp16=false on Windows CPU.
7. Add model-load, engine smoke, and real screenshot OCR tests. Require exit 0 and nonempty output before connecting the GUI.
8. Only then replace the current worker's recognize adapter and retain the existing editable result dialog.

## Why the primary app was not changed

PP-OCRv6 has different topology, preprocessing, output names, decoder, vocabulary, and ncnn minimum revision. A direct model-file swap is unsafe. The isolated reference passed with the exact PP-OCRv6 tiny assets and ncnn 20241226, but full GUI integration still needs a separate controlled change and regression pass.

No primary application source or packaged executable was changed by this research. Temporary trees are outside the workspace under C:/PaddleOCR-release and C:/ncnn-20241226-*.
