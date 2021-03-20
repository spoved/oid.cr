set(CMAKE_CXX_STANDARD_11)

# cmake_minimum_required(VERSION 3.17)
# project(raylib)

######################
# RAYLIB Setup
######################

# Config options
option(USE_RAYGUI "Include Raygui." ON)

set(BUILD_GAMES OFF)
set(BUILD_EXAMPLES OFF CACHE BOOL "" FORCE) # don't build the supplied examples
set(BUILD_GAMES OFF CACHE BOOL "" FORCE) # or games
set(SHARED ON)

add_subdirectory(raylib)

target_link_libraries(raylib_static)
target_link_libraries(glfw)

######################
# RAYGUI Setup
######################
if (${USE_RAYGUI})
  message(STATUS "RAYGUI is enabled")

  # Directory Variables
  set(RAYGUI_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/raygui)
  set(RAYGUI_SRC ${RAYGUI_ROOT}/src)
  set(RAYGUI_EXAMPLES ${RAYGUI_ROOT}/examples)

  # raygui
  add_library(raygui INTERFACE)
  file(GLOB sources ${RAYGUI_SRC}/*.h)
  set(RAYGUI_HEADERS ${sources})
  install(FILES ${RAYGUI_HEADERS} DESTINATION include)
  target_include_directories(raygui INTERFACE ${RAYGUI_SRC})
  target_link_libraries(raygui)
  
  target_link_libraries(raylib_static INTERFACE raygui ${RAYGUI_SRC})

  # Examples
  if (${BUILD_EXAMPLES})
    message(STATUS "RAYGUI BUILD_EXAMPLES is enabled")

    # Get the sources together
    set(example_dirs
            # custom_file_dialog
            image_raw_importer
            portable_window
            scroll_panel
            text_box_selection
            controls_test_suite
            image_exporter
            property_list
            text_editor
            )

    set(example_sources)
    set(example_resources)

    foreach (example_dir ${example_dirs})
      # Get the .c files
      file(GLOB sources ${RAYGUI_EXAMPLES}/${example_dir}/*.c)
      list(APPEND example_sources ${sources})

      # Any any resources
      file(GLOB resources ${RAYGUI_EXAMPLES}/${example_dir}/resources/*)
      list(APPEND example_resources ${resources})
    endforeach ()


    # Do each example
    foreach (example_source ${example_sources})
      # Create the basename for the example
      get_filename_component(example_name ${example_source} NAME)
      string(REPLACE ".c" "${OUTPUT_EXT}" example_name ${example_name})

      # Setup the example
      add_executable(${example_name} ${example_source})

      target_link_libraries(${example_name} PUBLIC raylib raygui)

      string(REGEX MATCH ".*/.*/" resources_dir ${example_source})
      string(APPEND resources_dir "resources")
    endforeach ()

    # Copy all of the resource files to the destination
    file(COPY ${example_resources} DESTINATION "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/resources/")
  endif ()
endif ()

