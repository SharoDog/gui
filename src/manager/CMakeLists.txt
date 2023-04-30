add_library(manager STATIC
	manager.cpp
)

target_link_libraries(manager PRIVATE communication asio Qt6::Core)
target_include_directories(manager INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
