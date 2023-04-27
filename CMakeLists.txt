cmake_minimum_required(VERSION 3.16)

project(sharo_gui VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 COMPONENTS Quick Gui REQUIRED )
qt_standard_project_setup()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
add_subdirectory(deps)
add_subdirectory(src/app)
add_subdirectory(src/manager)
add_subdirectory(src/communication)
