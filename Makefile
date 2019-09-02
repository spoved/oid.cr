# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.15

# Default target executed when no arguments are given to make.
default_target: all

.PHONY : default_target

# Allow only one "make -f Makefile2" at a time, but pass parallelism.
.NOTPARALLEL:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.15.2/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.15.2/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/homans/code/gitlab.com/hero-forge/oid.cr

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/homans/code/gitlab.com/hero-forge/oid.cr

#=============================================================================
# Targets provided globally by CMake.

# Special rule for the target list_install_components
list_install_components:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Available install components are: \"Unspecified\""
.PHONY : list_install_components

# Special rule for the target list_install_components
list_install_components/fast: list_install_components

.PHONY : list_install_components/fast

# Special rule for the target edit_cache
edit_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running CMake cache editor..."
	/usr/local/Cellar/cmake/3.15.2/bin/ccmake -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
.PHONY : edit_cache

# Special rule for the target edit_cache
edit_cache/fast: edit_cache

.PHONY : edit_cache/fast

# Special rule for the target rebuild_cache
rebuild_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running CMake to regenerate build system..."
	/usr/local/Cellar/cmake/3.15.2/bin/cmake -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
.PHONY : rebuild_cache

# Special rule for the target rebuild_cache
rebuild_cache/fast: rebuild_cache

.PHONY : rebuild_cache/fast

# Special rule for the target package_source
package_source:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Run CPack packaging tool for source..."
	/usr/local/Cellar/cmake/3.15.2/bin/cpack --config ./CPackSourceConfig.cmake /Users/homans/code/gitlab.com/hero-forge/oid.cr/CPackSourceConfig.cmake
.PHONY : package_source

# Special rule for the target package_source
package_source/fast: package_source

.PHONY : package_source/fast

# Special rule for the target package
package: preinstall
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Run CPack packaging tool..."
	/usr/local/Cellar/cmake/3.15.2/bin/cpack --config ./CPackConfig.cmake
.PHONY : package

# Special rule for the target package
package/fast: package

.PHONY : package/fast

# Special rule for the target install/local
install/local: preinstall
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Installing only the local directory..."
	/usr/local/Cellar/cmake/3.15.2/bin/cmake -DCMAKE_INSTALL_LOCAL_ONLY=1 -P cmake_install.cmake
.PHONY : install/local

# Special rule for the target install/local
install/local/fast: preinstall/fast
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Installing only the local directory..."
	/usr/local/Cellar/cmake/3.15.2/bin/cmake -DCMAKE_INSTALL_LOCAL_ONLY=1 -P cmake_install.cmake
.PHONY : install/local/fast

# Special rule for the target install/strip
install/strip: preinstall
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Installing the project stripped..."
	/usr/local/Cellar/cmake/3.15.2/bin/cmake -DCMAKE_INSTALL_DO_STRIP=1 -P cmake_install.cmake
.PHONY : install/strip

# Special rule for the target install/strip
install/strip/fast: preinstall/fast
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Installing the project stripped..."
	/usr/local/Cellar/cmake/3.15.2/bin/cmake -DCMAKE_INSTALL_DO_STRIP=1 -P cmake_install.cmake
.PHONY : install/strip/fast

# Special rule for the target install
install: preinstall
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Install the project..."
	/usr/local/Cellar/cmake/3.15.2/bin/cmake -P cmake_install.cmake
.PHONY : install

# Special rule for the target install
install/fast: preinstall/fast
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Install the project..."
	/usr/local/Cellar/cmake/3.15.2/bin/cmake -P cmake_install.cmake
.PHONY : install/fast

# The main all target
all: cmake_check_build_system
	$(CMAKE_COMMAND) -E cmake_progress_start /Users/homans/code/gitlab.com/hero-forge/oid.cr/CMakeFiles /Users/homans/code/gitlab.com/hero-forge/oid.cr/CMakeFiles/progress.marks
	$(MAKE) -f CMakeFiles/Makefile2 all
	$(CMAKE_COMMAND) -E cmake_progress_start /Users/homans/code/gitlab.com/hero-forge/oid.cr/CMakeFiles 0
.PHONY : all

# The main clean target
clean:
	$(MAKE) -f CMakeFiles/Makefile2 clean
.PHONY : clean

# The main clean target
clean/fast: clean

.PHONY : clean/fast

# Prepare targets for installation.
preinstall: all
	$(MAKE) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall

# Prepare targets for installation.
preinstall/fast:
	$(MAKE) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall/fast

# clear depends
depend:
	$(CMAKE_COMMAND) -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 1
.PHONY : depend

#=============================================================================
# Target rules for targets named bindings

# Build rule for target.
bindings: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 bindings
.PHONY : bindings

# fast build rule for target.
bindings/fast:
	$(MAKE) -f CMakeFiles/bindings.dir/build.make CMakeFiles/bindings.dir/build
.PHONY : bindings/fast

#=============================================================================
# Target rules for targets named format

# Build rule for target.
format: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 format
.PHONY : format

# fast build rule for target.
format/fast:
	$(MAKE) -f CMakeFiles/format.dir/build.make CMakeFiles/format.dir/build
.PHONY : format/fast

#=============================================================================
# Target rules for targets named raylib_static

# Build rule for target.
raylib_static: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 raylib_static
.PHONY : raylib_static

# fast build rule for target.
raylib_static/fast:
	$(MAKE) -f ext/raylib/src/CMakeFiles/raylib_static.dir/build.make ext/raylib/src/CMakeFiles/raylib_static.dir/build
.PHONY : raylib_static/fast

#=============================================================================
# Target rules for targets named glfw

# Build rule for target.
glfw: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 glfw
.PHONY : glfw

# fast build rule for target.
glfw/fast:
	$(MAKE) -f ext/raylib/src/external/glfw/src/CMakeFiles/glfw.dir/build.make ext/raylib/src/external/glfw/src/CMakeFiles/glfw.dir/build
.PHONY : glfw/fast

#=============================================================================
# Target rules for targets named glfw_objlib

# Build rule for target.
glfw_objlib: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 glfw_objlib
.PHONY : glfw_objlib

# fast build rule for target.
glfw_objlib/fast:
	$(MAKE) -f ext/raylib/src/external/glfw/src/CMakeFiles/glfw_objlib.dir/build.make ext/raylib/src/external/glfw/src/CMakeFiles/glfw_objlib.dir/build
.PHONY : glfw_objlib/fast

#=============================================================================
# Target rules for targets named shards

# Build rule for target.
shards: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 shards
.PHONY : shards

# fast build rule for target.
shards/fast:
	$(MAKE) -f lib/bindgen/CMakeFiles/shards.dir/build.make lib/bindgen/CMakeFiles/shards.dir/build
.PHONY : shards/fast

#=============================================================================
# Target rules for targets named bindgen_tool

# Build rule for target.
bindgen_tool: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 bindgen_tool
.PHONY : bindgen_tool

# fast build rule for target.
bindgen_tool/fast:
	$(MAKE) -f lib/bindgen/CMakeFiles/bindgen_tool.dir/build.make lib/bindgen/CMakeFiles/bindgen_tool.dir/build
.PHONY : bindgen_tool/fast

#=============================================================================
# Target rules for targets named intrinsics_gen

# Build rule for target.
intrinsics_gen: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 intrinsics_gen
.PHONY : intrinsics_gen

# fast build rule for target.
intrinsics_gen/fast:
	$(MAKE) -f lib/bindgen/clang/CMakeFiles/intrinsics_gen.dir/build.make lib/bindgen/clang/CMakeFiles/intrinsics_gen.dir/build
.PHONY : intrinsics_gen/fast

#=============================================================================
# Target rules for targets named bindgen

# Build rule for target.
bindgen: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 bindgen
.PHONY : bindgen

# fast build rule for target.
bindgen/fast:
	$(MAKE) -f lib/bindgen/clang/CMakeFiles/bindgen.dir/build.make lib/bindgen/clang/CMakeFiles/bindgen.dir/build
.PHONY : bindgen/fast

# Help Target
help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... clean"
	@echo "... depend"
	@echo "... list_install_components"
	@echo "... edit_cache"
	@echo "... rebuild_cache"
	@echo "... package_source"
	@echo "... package"
	@echo "... install/local"
	@echo "... bindings"
	@echo "... install/strip"
	@echo "... install"
	@echo "... format"
	@echo "... raylib_static"
	@echo "... glfw"
	@echo "... glfw_objlib"
	@echo "... shards"
	@echo "... bindgen_tool"
	@echo "... intrinsics_gen"
	@echo "... bindgen"
.PHONY : help



#=============================================================================
# Special targets to cleanup operation of make.

# Special rule to run CMake to check the build system integrity.
# No rule that depends on this can have commands that come from listfiles
# because they might be regenerated.
cmake_check_build_system:
	$(CMAKE_COMMAND) -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 0
.PHONY : cmake_check_build_system

