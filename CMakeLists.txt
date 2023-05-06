cmake_minimum_required(VERSION 3.16)

project(sharo_gui VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 COMPONENTS Quick Gui Network REQUIRED )
qt_standard_project_setup()
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/yunet.onnx ${CMAKE_BINARY_DIR}/yunet.onnx COPYONLY)
add_subdirectory(src/app)
add_subdirectory(src/manager)
add_subdirectory(src/communication)
add_subdirectory(src/video)
