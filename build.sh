#!/usr/bin/env bash

set -ex

root_dir=$(pwd)

cd_root() {
  cd ${root_dir}
}

make_clean() {
  cd ./ext
  make clean
  cd_root
}

# Update submodules
git submodule update --init --recursive

# Check bindgen
if [ ! -e ./lib/bindgen/clang/bindgen ]; then
  cd ./lib/bindgen/clang/
  make
  cd_root
fi

if [ ! -e ./lib/bindgen/bin/bindgen ]; then
  cd ./lib/bindgen
  shards build
  cd_root
fi

# Compile raylib
if [ ! -e ./ext/raylib/src/libraylib.a ]; then
  cd ./ext/raylib/src/
  make
  cd_root
fi

# Generate bindings
if [ ! -d ./src/ext ]; then
  mkdir ./src/ext
fi

./lib/bindgen/bin/bindgen ext/raylib.yml

cd_root

crystal tool format
crystal docs
