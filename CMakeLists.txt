project(oid)
cmake_minimum_required(VERSION 3.14)

add_subdirectory(ext)

# lib/bindgen/clang/bindgen
add_subdirectory(lib/bindgen)

# Find crystal bin
if(NOT EXISTS ${crystal_bin})
  find_program(crystal_bin crystal)
  message(STATUS "Found crystal exec: ${crystal_bin}")
endif()

if(NOT EXISTS ${shards_bin})
  find_program(shards_bin shards)
  message(STATUS "Found shards exec: ${shards_bin}")
endif()

if(NOT EXISTS ${bindgen_tool})
  find_program(bindgen_tool bindgen
    PATHS: ${PROJECT_SOURCE_DIR}/lib/bindgen/bin
  )
  message(STATUS "Found bindgen tool exec: ${bindgen_tool}")
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
  COMMAND ${bindgen_tool} ${PROJECT_SOURCE_DIR}/ext/raylib.yml
  DEPENDS shards glfw_objlib glfw raylib_static bindgen
)

add_custom_target(bindings-raygui ALL
  COMMAND ${bindgen_tool} ${PROJECT_SOURCE_DIR}/ext/raygui.yml
  DEPENDS shards glfw_objlib glfw raylib_static bindgen
)