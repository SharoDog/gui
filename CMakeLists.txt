cmake_minimum_required(VERSION 3.16)

project(sharo_gui VERSION 1.0.0 LANGUAGES CXX)

set(CPM_DOWNLOAD_VERSION 0.34.0)

if(CPM_SOURCE_CACHE)
  set(CPM_DOWNLOAD_LOCATION "${CPM_SOURCE_CACHE}/cpm/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
elseif(DEFINED ENV{CPM_SOURCE_CACHE})
  set(CPM_DOWNLOAD_LOCATION "$ENV{CPM_SOURCE_CACHE}/cpm/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
else()
  set(CPM_DOWNLOAD_LOCATION "${CMAKE_BINARY_DIR}/cmake/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
endif()

if(NOT (EXISTS ${CPM_DOWNLOAD_LOCATION}))
  message(STATUS "Downloading CPM.cmake to ${CPM_DOWNLOAD_LOCATION}")
  file(DOWNLOAD
       https://github.com/TheLartians/CPM.cmake/releases/download/v${CPM_DOWNLOAD_VERSION}/CPM.cmake
       ${CPM_DOWNLOAD_LOCATION}
  )
endif()

include(${CPM_DOWNLOAD_LOCATION})

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 COMPONENTS Quick Gui REQUIRED )
qt_standard_project_setup()
CPMAddPackage(
  NAME asio
  GIT_REPOSITORY "https://github.com/chriskohlhoff/asio"
  GIT_TAG "asio-1-27-0"
  DOWNLOAD_ONLY TRUE
)
if (asio_ADDED)
	add_library(asio INTERFACE IMPORTED)
	target_include_directories(asio INTERFACE ${asio_SOURCE_DIR}/asio/include)
endif()

get_target_property(ASIO_INCLUDES asio INCLUDE_DIRECTORIES)
message(STATUS ${asio_SOURCE_DIR})
message(STATUS ${ASIO_INCLUDES})

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
add_subdirectory(src/app)
add_subdirectory(src/manager)
add_subdirectory(src/communication)
