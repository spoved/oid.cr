IGNORE   := $(shell crystal run lib/bindgen/clang/find_clang.cr > Makefile.variables)
include Makefile.variables

UNAME_S := $(shell uname -s)

BINDGEN := bin/bindgen
CLANG_BINDGEN := lib/bindgen/clang/bindgen

RAY_LIB_LIB := ext/raylib/src/libraylib.a
RAY_LIB_CONFIG := ext/raylib.yml

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


all: raylib $(BINDGEN) bindings

bindings:
	VERBOSE=$(VERBOSE) \
	CXXFLAGS="$(CXXFLAGS)" \
	CLANG_BINDGEN="$(CLANG_BINDGEN)" \
	$(BINDGEN) $(RAY_LIB_CONFIG)

$(BINDGEN):
	clang_bindgen
	crystal build lib/bindgen/src/bindgen.cr -o $(BINDGEN)

clang_bindgen:
	make -C lib/bindgen/clang all

raylib:
	cmake ext/raylib -DBUILD_EXAMPLES=OFF -DBUILD_GAMES=OFF
	make -C ext/raylib raylib_static

clean:
	make -C ext/raylib clean
