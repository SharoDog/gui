add_library(communication STATIC
	communication.cpp
)

target_link_libraries(communication PRIVATE asio Qt6::Core)
target_include_directories(communication INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
