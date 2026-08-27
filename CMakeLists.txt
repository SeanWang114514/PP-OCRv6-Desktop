cmake_minimum_required(VERSION 3.21)
project(ChineseOCRLiteDesktop LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_BUILD_TYPE Release CACHE STRING "" FORCE)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded" CACHE STRING "" FORCE)
if(CMAKE_GENERATOR_PLATFORM STREQUAL "ARM64" OR CMAKE_SYSTEM_PROCESSOR MATCHES "ARM64|aarch64")
  set(NCNN_ROOT "${CMAKE_SOURCE_DIR}/third_party/ncnn-arm64")
  set(OpenCV_DIR "${CMAKE_SOURCE_DIR}/third_party/opencv-arm64/ARM64/vc17/staticlib")
  set(ncnn_DIR "${CMAKE_SOURCE_DIR}/third_party/ncnn-arm64/lib/cmake/ncnn")
else()
  set(NCNN_ROOT "${CMAKE_SOURCE_DIR}/third_party/ncnn")
  set(OpenCV_DIR "${CMAKE_SOURCE_DIR}/third_party/opencv/x64/vc17/staticlib")
  set(ncnn_DIR "${CMAKE_SOURCE_DIR}/third_party/ncnn/lib/cmake/ncnn")
endif()
find_package(ncnn CONFIG REQUIRED)
find_package(OpenCV CONFIG REQUIRED core imgproc imgcodecs)
find_package(OpenMP REQUIRED)
set(PPOCRV6_DIR "${CMAKE_SOURCE_DIR}/ppocrv6_engine")
set(PPOCRV6_SRC ${PPOCRV6_DIR}/angle_net.cpp ${PPOCRV6_DIR}/crnn_net.cpp ${PPOCRV6_DIR}/db_net.cpp ${PPOCRV6_DIR}/ocr_engine.cpp ${PPOCRV6_DIR}/utils.cpp ${PPOCRV6_DIR}/3rdparty/clipper2/clipper.engine.cpp ${PPOCRV6_DIR}/3rdparty/clipper2/clipper.offset.cpp ${PPOCRV6_DIR}/3rdparty/clipper2/clipper.rectclip.cpp)
add_executable(ChineseOCRLiteDesktop WIN32 src/main.cpp ${PPOCRV6_SRC} translation_assets/translator.rc)
target_include_directories(ChineseOCRLiteDesktop PRIVATE "${PPOCRV6_DIR}" "${PPOCRV6_DIR}/3rdparty" "${CMAKE_SOURCE_DIR}/third_party/ncnn/include" "${CMAKE_SOURCE_DIR}/third_party/opencv/include")
target_compile_definitions(ChineseOCRLiteDesktop PRIVATE UNICODE _UNICODE WIN32_LEAN_AND_MEAN NOMINMAX __EXEC__)
if(MSVC)
  target_compile_options(ChineseOCRLiteDesktop PRIVATE /utf-8)
endif()
set_property(TARGET ChineseOCRLiteDesktop PROPERTY MSVC_RUNTIME_LIBRARY "MultiThreaded")
target_link_libraries(ChineseOCRLiteDesktop PRIVATE ncnn ${OpenCV_LIBS} OpenMP::OpenMP_CXX user32 gdi32 msimg32 winhttp dwmapi)

# Keep the executable runnable directly from the CMake output directory.
add_custom_command(TARGET ChineseOCRLiteDesktop POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy_directory
    "${CMAKE_SOURCE_DIR}/models" "$<TARGET_FILE_DIR:ChineseOCRLiteDesktop>/models"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${CMAKE_SOURCE_DIR}/ppocrv6_config.json" "$<TARGET_FILE_DIR:ChineseOCRLiteDesktop>/ppocrv6_config.json"
)