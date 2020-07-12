#include "bindgen_helper.hpp"
#define RAYGUI_IMPLEMENTATION
#define RAYGUI_SUPPORT_RICONS
#include <raylib.h>

extern "C" TextureCubemap * bg____LoadTextureCubemap_STATIC_Image_int(Image image, int layoutType) {
  return new (UseGC) TextureCubemap (::LoadTextureCubemap(image, layoutType));
}

extern "C" Music * bg____LoadMusicStream_STATIC_const_char_X(const char * fileName) {
  return new (UseGC) Music (::LoadMusicStream(fileName));
}

