add_library(manager STATIC
	manager.cpp
	FileManager.cpp
)

target_link_libraries(manager PRIVATE communication Qt6::Network)
target_include_directories(manager INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
