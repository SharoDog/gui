add_library(video STATIC
	video.cpp
)

target_link_libraries(video PRIVATE Qt6::Network ${OpenCV_LIBS})
target_include_directories(video INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
