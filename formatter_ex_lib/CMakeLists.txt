cmake_minimum_required(VERSION 3.29)

project(formatter_ex)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Установим путь к директории formatter_ex_lib
set(CMAKE_CURRENT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/formatter_ex_lib)

# Явно перечислим исходные файлы
set(SOURCES
    formatter_ex.cpp
)

# Создадим библиотеку formatter_ex
add_library(formatter_ex STATIC ${SOURCES})

# Установим директорию для поиска заголовочных файлов
include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/formatter_lib)

# Добавим зависимость от библиотеки formatter
target_link_libraries(formatter_ex formatter)
