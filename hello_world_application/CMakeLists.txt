cmake_minimum_required(VERSION 3.29)
project(hello_world)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CURRENT_SOURCE_DIR /Users/mihailerosenko/z1qnezt/workspace/tasks/lab03)

add_executable(hello_world ${CMAKE_CURRENT_SOURCE_DIR}/hello_world_application/hello_world.cpp)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/formatter_lib ${CMAKE_CURRENT_SOURCE_DIR}/formatter_ex_lib)

find_library(formatter NAMES libformatter.a PATHS ${CMAKE_CURRENT_SOURCE_DIR}/formatter_lib)
find_library(formatter_ex NAMES libformatter_ex.a PATHS ${CMAKE_CURRENT_SOURCE_DIR}/formatter_ex_lib)

target_link_libraries(hello_world ${formatter} ${formatter_ex})