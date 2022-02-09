cmake_minimum_required(VERSION 3.16)
project(simulation)

set(CMAKE_CXX_STANDARD 14)

add_executable(simulation main.cpp LeastSquare.cpp)
add_executable(leastsquare LeastSquare.cpp LeastSquare.cpp)