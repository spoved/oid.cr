set(CMAKE_CXX_STANDARD_11)

######################
# RAYLIB Setup
######################

set(BUILD_EXAMPLES OFF)
set(BUILD_GAMES OFF)

set(BUILD_EXAMPLES OFF CACHE BOOL "" FORCE) # don't build the supplied examples
set(BUILD_GAMES    OFF CACHE BOOL "" FORCE) # or games
set(SHARED ON)

add_subdirectory(raylib)

# get_target_property(_aliased raylib ALIASED_TARGET)
# if(_aliased)
#   message(STATUS "The name raylib is an ALIAS for ${_aliased}.")
# endif()

target_link_libraries(raylib_static)
target_link_libraries(glfw)