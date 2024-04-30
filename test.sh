root=./
cmake --build $root/formatter_lib
cmake --build $root/formatter_ex_lib
cmake --build $root/hello_world_application
cmake --build $root/solver_lib
cmake --build $root/solver_application

$root/hello_world_application/_build/hello_world
echo -e '1\n2\n3' | $root/solver_application/_build/solver

