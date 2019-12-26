set(CMAKE_CXX_STANDARD_11)

######################
# LLVM Setup
######################

set(LLVM_ENABLE_LIBCXX ON)

# Search for LLVM
find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM: ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
string(REGEX MATCH "^([0-9]+)" LLVM_VER ${LLVM_PACKAGE_VERSION})
message(STATUS "LLVM Major version: ${LLVM_VER}")

# Add llvm version definition
add_definitions(-D__LLVM_VERSION_${LLVM_VER})


# Find the LLVM clang++ path
message(STATUS "LLVM Tools Dir: ${LLVM_TOOLS_BINARY_DIR}")

find_program(clang_bin "clang++" PATHS: ${LLVM_TOOLS_BINARY_DIR})
message(STATUS "Found clang bin: ${clang_bin}")
set(CMAKE_CXX_COMPILER ${clang_bin})
message(STATUS "Using clang++ exec: ${CMAKE_CXX_COMPILER}")

# Find llvm-config bin
find_program(llvm_config_bin "llvm-config" PATHS: ${LLVM_TOOLS_BINARY_DIR})
message(STATUS "Using llvm-config exec: ${llvm_config_bin}")

# Include LLVM dirs
message(STATUS "Include LLVM dirs: ${LLVM_INCLUDE_DIRS}")
include_directories(${LLVM_INCLUDE_DIRS})

message(STATUS "Add LLVM definitions: ${LLVM_DEFINITIONS}")
add_definitions(${LLVM_DEFINITIONS})

# Find the libraries that correspond to the LLVM components
# that we wish to use
llvm_map_components_to_libnames(llvm_libs all)

# GC
include_directories(/usr/local/Cellar/bdw-gc/8.0.4/include)

######################
# RAYGUI Setup
######################

include_directories(
  raylib/src 
  raylib/src/external/glfw/src
  raygui/src
)

add_library(raygui raygui_bindings.cpp)