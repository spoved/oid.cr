#include "bindgen_helper.hpp"
#define RAYGUI_IMPLEMENTATION
#define RAYGUI_SUPPORT_RICONS
#include <raylib.h>

extern "C" TextureCubemap * bg____LoadTextureCubemap_STATIC_Image_int(Image image, int layoutType) {
  return new (UseGC) TextureCubemap (::LoadTextureCubemap(image, layoutType));
}

extern "C" TextureCubemap * bg____GenTextureCubemap_STATIC_Shader_Texture2D_int_int(Shader shader, Texture panorama, int size, int format) {
  return new (UseGC) TextureCubemap (::GenTextureCubemap(shader, panorama, size, format));
}

extern "C" TextureCubemap * bg____GenTextureIrradiance_STATIC_Shader_TextureCubemap_int(Shader shader, TextureCubemap & cubemap, int size) {
  return new (UseGC) TextureCubemap (::GenTextureIrradiance(shader, cubemap, size));
}

extern "C" TextureCubemap * bg____GenTexturePrefilter_STATIC_Shader_TextureCubemap_int(Shader shader, TextureCubemap & cubemap, int size) {
  return new (UseGC) TextureCubemap (::GenTexturePrefilter(shader, cubemap, size));
}

extern "C" Music * bg____LoadMusicStream_STATIC_const_char_X(const char * fileName) {
  return new (UseGC) Music (::LoadMusicStream(fileName));
}

