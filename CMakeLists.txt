if (POLICY CMP0048)
  cmake_policy(SET CMP0048 NEW)
endif (POLICY CMP0048)

project(oid VERSION 0.1.1)

cmake_minimum_required(VERSION 3.14)

# To define a specific LLVM install set the path here:
# set(LLVM_DIR /usr/local/opt/llvm/lib/cmake/llvm)
# set(LLVM_DIR /usr/local/opt/llvm@7/lib/cmake/llvm)
# set(LLVM_DIR /usr/local/opt/llvm@9/lib/cmake/llvm)

# set(LLVM_DIR "/usr/local/Cellar/llvm@9/9.0.1_2/lib/cmake/llvm/")
# GC
# include_directories(/usr/local/Cellar/bdw-gc/8.0.4_1/include)

# lib/bindgen/clang/bindgen
# add_subdirectory(lib/bindgen)

# add_subdirectory(ext)

# Find crystal bin
if(NOT EXISTS ${crystal_bin})
  find_program(crystal_bin crystal)
  message(STATUS "Found crystal exec: ${crystal_bin}")
endif()

if(NOT EXISTS ${shards_bin})
  find_program(shards_bin shards)
  message(STATUS "Found shards exec: ${shards_bin}")
endif()

if(NOT EXISTS ${PROJECT_SOURCE_DIR}/bin)
  file(MAKE_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)
endif()

add_custom_target(format ALL
  COMMAND ${crystal_bin} tool format ${PROJECT_SOURCE_DIR}/src
)

add_custom_target(docs ALL
  COMMAND rm -rf ./docs/* && ${crystal_bin} docs ./lib/entitas/src/entitas.cr ./src/oid.cr ./src/raylib.cr
)

add_custom_target(example
  COMMAND ${crystal_bin} run examples/02/main.cr --error-trace --exclude-warnings /usr/local/Cellar/crystal
  DEPENDS docs
)

add_custom_target(bindings ALL
  COMMAND ${PROJECT_SOURCE_DIR}/ext/gen.sh && crystal tool format
  # DEPENDS shards glfw_objlib glfw raylib_static bindgen parser
)