cmake_minimum_required(VERSION 3.6)
project(example)
include("${CMAKE_SOURCE_DIR}/DefaultConfig.cmake" REQUIRED)
include("${CMAKE_SOURCE_DIR}/FindPackages.cmake" REQUIRED)

# sources
file(GLOB ALL_SOURCES "src/*.h" "src/*.cpp")

# targets
message("ALL_SOURCES: ${ALL_SOURCES}")
message("ALL_LIBRARIES: ${ALL_LIBRARIES}")
add_executable(${CMAKE_PROJECT_NAME} ${ALL_SOURCES})
target_link_libraries(${CMAKE_PROJECT_NAME} ${ALL_LIBRARIES})

