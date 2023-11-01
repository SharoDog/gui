cmake_minimum_required(VERSION 3.19)

project(sharo_gui VERSION 1.0.0 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 6.6.0 COMPONENTS Quick Gui Network WebView REQUIRED)
set(QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")

qt_standard_project_setup(REQUIRES 6.6)
qt_policy(
	SET QTP0001 NEW
)
qt_policy(
	SET QTP0002 NEW
)

qt_add_executable(sharo_gui 
	src/main.cpp)

if (NOT ANDROID)
	find_package(OpenCV REQUIRED)
	include_directories(${OpenCV_INCLUDE_DIRS})
	
	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

	add_subdirectory(src/video)
	target_link_libraries(sharo_gui PRIVATE video)
else()
	set_property(TARGET sharo_gui APPEND PROPERTY
		QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android
	)
endif(NOT ANDROID)

add_subdirectory(src/views)
add_subdirectory(src/manager)
add_subdirectory(src/communication)

target_link_libraries(sharo_gui PRIVATE viewsplugin manager communication Qt6::Gui Qt6::Quick Qt6::Network Qt6::WebView)
