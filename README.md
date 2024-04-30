# Homework 

Представьте, что вы стажер в компании "Formatter Inc.".

## Задание 1
Вам поручили перейти на систему автоматизированной сборки **CMake**.
Исходные файлы находятся в директории [formatter_lib](formatter_lib).
В этой директории находятся файлы для статической библиотеки *formatter*.
Создайте `CMakeList.txt` в директории [formatter_lib](formatter_lib),
с помощью которого можно будет собирать статическую библиотеку *formatter*.

```bash
cmake --version
```
```
cmake version 3.29.0

CMake suite maintained and supported by Kitware (kitware.com/cmake).
```
```bash
cd ./formatter_lib/
```
```bash
cat >> CMakeLists.txt <<EOF
cmake_minimum_required(VERSION 3.29)
project(formatter)
EOF

```
```bash
cat >> CMakeLists.txt <<EOF
set(CMAKE_CXX_STANDART 20)
set(CMAKE_CXX_STANDART_REQUIRED ON)
EOF

```
```bash
cat >> CMakeLists.txt <<EOF
add_library(formatter STATIC \${CMAKE_CURRENT_SOURCE_DIR}/formatter.cpp)
EOF

```
```bash
cat >> CMakeLists.txt <<EOF
include_directories(\${CMAKE_CURRENT_SOURCE_DIR})
EOF

```
---
```bash
cmake -H. -B_build
```
### Вывод:
```
-- The C compiler identification is AppleClang 15.0.0.15000309
-- The CXX compiler identification is AppleClang 15.0.0.15000309
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done (0.7s)
-- Generating done (0.0s)
-- Build files have been written to: /Users/mihailerosenko/z1qnezt/workspace/tasks/lab03/formatter_lib/_build
```
---
### Создание файлов formatter.o, libformatter.a:
```bash
 g++ -c formatter.cpp -o formatter.o
```
```bash
 ar rcs libformatter.a formatter.o
```
---
### Содержимое CMakeLists.txt:
```
cmake_minimum_required(VERSION 3.29)

project(formatter)

set(CMAKE_CXX_STANDART 20)
set(CMAKE_CXX_STANDART_REQUIRED ON)

add_library(formatter STATIC ${CMAKE_CURRENT_SOURCE_DIR}/formatter.cpp)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
```


## Задание 2
У компании "Formatter Inc." есть перспективная библиотека,
которая является расширением предыдущей библиотеки. Т.к. вы уже овладели
навыком созданием `CMakeList.txt` для статической библиотеки *formatter*, ваш 
руководитель поручает заняться созданием `CMakeList.txt` для библиотеки 
*formatter_ex*, которая в свою очередь использует библиотеку *formatter*.

```bash
cd ../formatter_ex_lib/
```
```bash
cat >> CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.29)
project(formatter_ex)
EOF
```
```bash
cat >> CMakeLists.txt <<EOF
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CURRENT_SOURCE_DIR /Users/mihailerosenko/z1qnezt/workspace/tasks/lab03/formatter_ex_lib)
EOF
```
```bash
cat >> CMakeLists.txt << EOF
add_library(formatter_ex STATIC ${CMAKE_CURRENT_SOURCE_DIR}/formatter_ex.cpp)
EOF
```
```bash
cat >> CMakeLists.txt << EOF
include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/formatter_lib)
EOF
```
```bash
cat >> CMakeLists.txt << EOF
target_link_libraries(formatter_ex formatter)
EOF
```
---
```bash
cmake -H. -B_build
```
### Вывод:
```
-- The C compiler identification is AppleClang 15.0.0.15000309
-- The CXX compiler identification is AppleClang 15.0.0.15000309
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done (0.6s)
-- Generating done (0.0s)
-- Build files have been written to: /Users/mihailerosenko/z1qnezt/workspace/tasks/lab03/formatter_ex_lib/_build
```
---
### Создание файлов formatter_ex.o, libformatter_ex.a:
```bash
 g++ -c formatter_ex.cpp -o formatter_ex.o
```
```bash
 ar rcs libformatter_ex.a formatter_ex.o
```
---
### Содержимое CMakeLists.txt:
```
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
```
---


## Задание 3
Конечно же ваша компания предоставляет примеры использования своих библиотек.
Чтобы продемонстрировать как работать с библиотекой *formatter_ex*,
вам необходимо создать два `CMakeList.txt` для двух простых приложений:
* *hello_world*, которое использует библиотеку *formatter_ex*;
* *solver*, приложение которое испольует статические библиотеки *formatter_ex* и *solver_lib*.
### 1. Hello_world_application
```bash
cd ../hello_world_application
```
```bash
cmake_minimum_required(VERSION 3.29)
project(hello_world)
```
```bash
cat >> CMakeLists.txt <<EOF
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CURRENT_SOURCE_DIR /Users/mihailerosenko/z1qnezt/workspace/tasks/lab03)
EOF
```
```bash
cat >> CMakeLists.txt << EOF
add_executable(hello_world ${CMAKE_CURRENT_SOURCE_DIR}/hello_world_application/hello_world.cpp)
EOF
```
```bash
cat >> ./CMakeLists.txt << EOF
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/formatter_lib ${CMAKE_CURRENT_SOURCE_DIR}/formatter_ex_lib)
EOF
```
```bash
cat >> CMakeLists.txt << EOF
find_library(formatter NAMES libformatter.a PATHS ${CMAKE_CURRENT_SOURCE_DIR}/formatter_lib)
find_library(formatter_ex NAMES libformatter_ex.a PATHS ${CMAKE_CURRENT_SOURCE_DIR}/formatter_ex_lib)
EOF
```
```bash
cat >> CMakeLists.txt << EOF
target_link_libraries(hello_world ${formatter} ${formatter_ex})
EOF
```
---
```bash
cmake -H. -B_build
```
### Вывод:
```
-- The C compiler identification is AppleClang 15.0.0.15000309
-- The CXX compiler identification is AppleClang 15.0.0.15000309
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done (0.7s)
-- Generating done (0.0s)
-- Build files have been written to: /Users/mihailerosenko/z1qnezt/workspace/tasks/lab03/hello_world_application/_build
```
---
### Содержимое CMakeLists.txt:
```
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
```
---
```bash
cmake --build _build
```
### Вывод:
```
[ 50%] Building CXX object CMakeFiles/hello_world.dir/hello_world.cpp.o
[100%] Linking CXX executable hello_world
[100%] Built target hello_world
```
---

### 2. Solver_application
```bash
cd ../solver_lib/
```
---
### Создание файлов formatter_ex.o, libformatter_ex.a:
```bash
 g++ -c solver.cpp -o solver.o
```
```bash
 ar rcs libsolver.a solver.o
```
---
```bash
cd ../solver_application/
```
```bash
cat >> ./CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.29)
project(solver)
EOF
```
```bash
cat >> CMakeLists.txt <<EOF
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CURRENT_SOURCE_DIR /Users/mihailerosenko/z1qnezt/workspace/tasks/lab03)
EOF
```
```bash
cat >> ./CMakeLists.txt << EOF
add_library(solver_lib STATIC ${CMAKE_CURRENT_SOURCE_DIR}/solver_lib/solver.cpp)
EOF
```
```bash
cat >> ./CMakeLists.txt << EOF
include_directories(/solver_lib /formatter_lib /formatter_ex_lib)
EOF
```
```bash
cat >> CMakeLists.txt << EOF
add_executable(solver ${CMAKE_CURRENT_SOURCE_DIR}/solver_application/equation.cpp)
EOF
```
```bash
cat >> CMakeLists.txt << EOF
find_library(formatter NAMES libformatter.a PATHS ${CMAKE_CURRENT_SOURCE_DIR}/formatter_lib)
find_library(formatter_ex NAMES libformatter_ex.a PATHS ${CMAKE_CURRENT_SOURCE_DIR}/formatter_ex_lib)
find_library(solver_lib NAMES libsolver.a PATHS ${CMAKE_CURRENT_SOURCE_DIR}/solver_lib)
 EOF
```
```bash
cat >> CMakeLists.txt << EOF
target_link_libraries(solver ${formatter} ${formatter_ex} ${solver_lib})
EOF
```
---
```bash
cmake -H. -B_build
```
### Вывод:
```
-- The C compiler identification is AppleClang 15.0.0.15000309
-- The CXX compiler identification is AppleClang 15.0.0.15000309
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done (0.7s)
-- Generating done (0.0s)
-- Build files have been written to: /Users/mihailerosenko/z1qnezt/workspace/tasks/lab03/solver_application/_build
```
---
### Содержимое CMakeLists.txt:
```
cmake_minimum_required(VERSION 3.29)
project(solver)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CURRENT_SOURCE_DIR /Users/mihailerosenko/z1qnezt/workspace/tasks/lab03)

# Добавляем директиву include_directories для поиска заголовочных файлов
include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/solver_lib
    ${CMAKE_CURRENT_SOURCE_DIR}/formatter_lib
    ${CMAKE_CURRENT_SOURCE_DIR}/formatter_ex_lib
)

# Создаем библиотеку solver_lib
add_library(solver_lib STATIC ${CMAKE_CURRENT_SOURCE_DIR}/solver_lib/solver.cpp)

# Создаем исполняемый файл solver и связываем его с библиотеками
add_executable(solver ${CMAKE_CURRENT_SOURCE_DIR}/solver_application/equation.cpp)

# Ищем библиотеки formatter, formatter_ex, и solver_lib
find_library(formatter NAMES libformatter.a PATHS ${CMAKE_CURRENT_SOURCE_DIR}/formatter_lib)
find_library(formatter_ex NAMES libformatter_ex.a PATHS ${CMAKE_CURRENT_SOURCE_DIR}/formatter_ex_lib)
find_library(solver_lib NAMES libsolver.a PATHS ${CMAKE_CURRENT_SOURCE_DIR}/solver_lib)

# Связываем исполняемый файл с библиотеками
target_link_libraries(solver ${formatter} ${formatter_ex} ${solver_lib})
```
---
```bash
cmake --build _build
```
### Вывод:
```
[ 25%] Building CXX object CMakeFiles/solver_lib.dir/Users/mihailerosenko/z1qnezt/workspace/tasks/lab03/solver_lib/solver.cpp.o
[ 50%] Linking CXX static library libsolver_lib.a
[ 50%] Built target solver_lib
[ 75%] Building CXX object CMakeFiles/solver.dir/equation.cpp.o
[100%] Linking CXX executable solver
[100%] Built target solver
```
