#include <cstdio>
#include <ncnn/net.h>
#include <ncnn/cpu.h>

int main(int argc, char** argv) {
    if (argc < 3) return 2;
    ncnn::Net net;
    net.opt.num_threads = 1;
    net.opt.lightmode = false;
    net.opt.use_packing_layout = false;
    net.opt.use_winograd_convolution = false;
    net.opt.use_sgemm_convolution = false;
    int p = net.load_param(argv[1]);
    int m = net.load_model(argv[2]);
    std::fprintf(stderr, "load param=%d model=%d\n", p, m);
    if (p || m) return 3;
    const int w = argc > 3 ? std::atoi(argv[3]) : 32;
    const int h = argc > 4 ? std::atoi(argv[4]) : 32;
    std::fprintf(stderr, "input shape=%dx%d\n", w, h);
    ncnn::Mat input(w, h, 3);
    input.fill(0.f);
    ncnn::Extractor ex = net.create_extractor();
    ex.set_num_threads(1);
    const char* inputName = argc > 5 ? argv[5] : "input0";
    const char* outputName = argc > 6 ? argv[6] : "out1";
    int i = ex.input(inputName, input);
    std::fprintf(stderr, "input=%d name=%s\n", i, inputName);
    ncnn::Mat out;
    int e = ex.extract(outputName, out);
    std::fprintf(stderr, "extract=%d dims=%d w=%d h=%d c=%d\n", e, out.dims, out.w, out.h, out.c);
    return e == 0 ? 0 : 4;
}
