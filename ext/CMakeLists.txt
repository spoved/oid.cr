cmake_minimum_required(VERSION 3.17)
project(oid_bindings)

include(../lib/bindgen/clang/llvm.cmake)

######################
# RAYLIB Setup
######################

# Config options
set(BUILD_GAMES OFF)
set(BUILD_EXAMPLES OFF CACHE BOOL "" FORCE) # don't build the supplied examples
set(BUILD_GAMES OFF CACHE BOOL "" FORCE) # or games

set(RAYGUI_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/raygui)
set(RAYGUI_SRC ${RAYGUI_ROOT}/src)
set(RAYLIB_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/raylib)
set(RAYLIB_SRC ${RAYLIB_ROOT}/src)
set(RAYGUI_IMPLEMENTATION)
file(GLOB raygui_sources ${RAYGUI_SRC}/*.h)

# Raylib
add_subdirectory(raylib)

include_directories(/usr/local/include ${RAYGUI_SRC} ${RAYLIB_SRC})
set(SOURCE_FILES oid_bindings.cpp bindgen_helper.hpp ${raygui_sources})
add_library(oid_bindings ${SOURCE_FILES})
target_link_libraries(oid_bindings raylib_static gc gccpp gctba c++)
set_target_properties(oid_bindings PROPERTIES LINKER_LANGUAGE CXX)
