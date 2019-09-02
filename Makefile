IGNORE   := $(shell crystal run lib/bindgen/clang/find_clang.cr > Makefile.variables)
include Makefile.variables

UNAME_S := $(shell uname -s)


LIBS := $(LLVM_LD_FLAGS) $(CLANG_LIBS) -ldl -lz -lcurses -lpcre
DEFINES := -D__LLVM_VERSION_$(LLVM_VERSION)
CXXFLAGS := $(LLVM_CXX_FLAGS) $(DEFINES) -Iinclude $(CLANG_INCLUDES)
VERBOSE := true

# If OSX
ifeq ($(UNAME_S),Darwin)
	ifeq ($(LLVM_VERSION), 4)
		# No -pthread on OSX for LLVM 4
	else
		# Add -pthread if over 4
		LIBS += -pthread
	endif # end ifeq ($(LLVM_VERSION), 4)
else # If not OSX
	# Add -ltinfo and -pthread
	LIBS += -ltinfo -pthread
endif # end ifeq ($(UNAME_S),Darwin)

# Vars
BIN_DIR := bin

# Bindgen vars
BINDGEN_LIB_DIR := lib/bindgen
BINDGEN_BIN := $(BIN_DIR)/bindgen
BINDGEN_CLANG_BIN := $(BINDGEN_LIB_DIR)/clang/bindgen

# Ray lib vars
RAY_LIB_DIR := ext/raylib
RAY_LIB_LIB := $(RAY_LIB_DIR)/src/libraylib.a
RAY_LIB_CONFIG := ext/raylib.yml
RAY_LIB_BINDING := src/ext/raylib/binding.cr
RAY_OBJ_DIR := $(RAY_LIB_DIR)/src/CMakeFiles/raylib_static.dir
RAY_GLFW_OBJ_DIR := $(RAY_LIB_DIR)/src/external/glfw/src/CMakeFiles/glfw_objlib.dir
RAY_GLFW_LIB := $(RAY_LIB_DIR)/src/external/glfw/src/libglfw3.a

#### Recipies ####

$(BINDGEN_CLANG_BIN) :
	$(MAKE) -C lib/bindgen/clang all

$(BINDGEN_BIN) : $(BINDGEN_CLANG_BIN)
	crystal build lib/bindgen/src/bindgen.cr --release -o $(BINDGEN_BIN)

$(RAY_LIB_LIB) :
	cmake ext/raylib -DBUILD_EXAMPLES=OFF -DBUILD_GAMES=OFF
	$(MAKE) -C ext/raylib raylib_static

$(RAY_LIB_BINDING) : $(BINDGEN_BIN) $(RAY_LIB_LIB);
	VERBOSE=$(VERBOSE) BINDGEN_CLANG_BIN="$(BINDGEN_CLANG_BIN)" \
	RAY_GLFW_LIB="$(RAY_GLFW_LIB)" \
	RAY_LIB_LIB="$(RAY_LIB_LIB)" \
	CLANG_INCLUDES="$(CLANG_INCLUDES)" \
	CLANG_LIBS="$(CLANG_LIBS)" \
	$(BINDGEN_BIN) $(RAY_LIB_CONFIG)

$(RAY_OBJ_DIR)/%.o : $(RAY_LIB_DIR)/src/%.c

$(RAY_GLFW_OBJ_DIR)/%.o : $(RAY_LIB_DIR)/src/external/glfw/src/%.c

.PHONY: clean_bindings
clean_bindings:
	rm -f $(RAY_LIB_BINDING)

.PHONY: bindings
bindings: clean_bindings $(RAY_LIB_BINDING) format

all: $(BINDGEN_CLANG_BIN) $(BINDGEN_BIN) $(RAY_LIB_LIB) $(RAY_LIB_BINDING) format
.PHONY: all

.PHONY: format
format:
	crystal tool format src/

.PHONY: clean
clean:
	$(MAKE) -C $(BINDGEN_LIB_DIR)/clang clean
	$(MAKE) -C $(RAY_LIB_DIR) clean
	rm -f $(BINDGEN_BIN) $(BINDGEN_CLANG_BIN) \
		$(BINDGEN_LIB_DIR)/clang/build/*.o \
		$(RAY_LIB_LIB)  $(RAY_OBJ_DIR)/*.o \
		$(RAY_GLFW_LIB) $(RAY_GLFW_OBJ_DIR)/*.o \
		$(RAY_LIB_BINDING)
