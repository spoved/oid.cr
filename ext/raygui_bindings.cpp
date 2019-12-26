#include "bindgen_helper.hpp"
#define RAYGUI_IMPLEMENTATION
#define RAYGUI_SUPPORT_RICONS
#include <raygui.h>

extern "C" Ray * bg____GetMouseRay_STATIC_Vector2_Camera(Vector2 & mousePosition, Camera & camera) {
  return new (UseGC) Ray (::GetMouseRay(mousePosition, camera));
}

extern "C" Vector2 * bg____GetWorldToScreen_STATIC_Vector3_Camera(Vector3 & position, Camera & camera) {
  return new (UseGC) Vector2 (::GetWorldToScreen(position, camera));
}

extern "C" Matrix * bg____GetCameraMatrix_STATIC_Camera(Camera & camera) {
  return new (UseGC) Matrix (::GetCameraMatrix(camera));
}

extern "C" Vector4 * bg____ColorNormalize_STATIC_Color(Color & color) {
  return new (UseGC) Vector4 (::ColorNormalize(color));
}

extern "C" Vector3 * bg____ColorToHSV_STATIC_Color(Color & color) {
  return new (UseGC) Vector3 (::ColorToHSV(color));
}

extern "C" Color * bg____ColorFromHSV_STATIC_Vector3(Vector3 & hsv) {
  return new (UseGC) Color (::ColorFromHSV(hsv));
}

extern "C" Color * bg____GetColor_STATIC_int(int hexValue) {
  return new (UseGC) Color (::GetColor(hexValue));
}

extern "C" Color * bg____Fade_STATIC_Color_float(Color & color, float alpha) {
  return new (UseGC) Color (::Fade(color, alpha));
}

extern "C" Vector2 * bg____GetMousePosition_STATIC_() {
  return new (UseGC) Vector2 (::GetMousePosition());
}

extern "C" Vector2 * bg____GetTouchPosition_STATIC_int(int index) {
  return new (UseGC) Vector2 (::GetTouchPosition(index));
}

extern "C" Vector2 * bg____GetGestureDragVector_STATIC_() {
  return new (UseGC) Vector2 (::GetGestureDragVector());
}

extern "C" Vector2 * bg____GetGesturePinchVector_STATIC_() {
  return new (UseGC) Vector2 (::GetGesturePinchVector());
}

extern "C" Rectangle * bg____GetCollisionRec_STATIC_Rectangle_Rectangle(Rectangle & rec1, Rectangle & rec2) {
  return new (UseGC) Rectangle (::GetCollisionRec(rec1, rec2));
}

extern "C" Image * bg____LoadImage_STATIC_const_char_X(const char * fileName) {
  return new (UseGC) Image (::LoadImage(fileName));
}

extern "C" Image * bg____LoadImageEx_STATIC_Color_X_int_int(Color * pixels, int width, int height) {
  return new (UseGC) Image (::LoadImageEx(pixels, width, height));
}

extern "C" Image * bg____LoadImagePro_STATIC_void_X_int_int_int(void * data, int width, int height, int format) {
  return new (UseGC) Image (::LoadImagePro(data, width, height, format));
}

extern "C" Image * bg____LoadImageRaw_STATIC_const_char_X_int_int_int_int(const char * fileName, int width, int height, int format, int headerSize) {
  return new (UseGC) Image (::LoadImageRaw(fileName, width, height, format, headerSize));
}

extern "C" Texture2D * bg____LoadTexture_STATIC_const_char_X(const char * fileName) {
  return new (UseGC) Texture2D (::LoadTexture(fileName));
}

extern "C" Texture2D * bg____LoadTextureFromImage_STATIC_Image(Image & image) {
  return new (UseGC) Texture2D (::LoadTextureFromImage(image));
}

extern "C" TextureCubemap * bg____LoadTextureCubemap_STATIC_Image_int(Image & image, int layoutType) {
  return new (UseGC) TextureCubemap (::LoadTextureCubemap(image, layoutType));
}

extern "C" RenderTexture2D * bg____LoadRenderTexture_STATIC_int_int(int width, int height) {
  return new (UseGC) RenderTexture2D (::LoadRenderTexture(width, height));
}

extern "C" Image * bg____GetTextureData_STATIC_Texture2D(Texture2D & texture) {
  return new (UseGC) Image (::GetTextureData(texture));
}

extern "C" Image * bg____GetScreenData_STATIC_() {
  return new (UseGC) Image (::GetScreenData());
}

extern "C" Image * bg____ImageCopy_STATIC_Image(Image & image) {
  return new (UseGC) Image (::ImageCopy(image));
}

extern "C" Image * bg____ImageText_STATIC_const_char_X_int_Color(const char * text, int fontSize, Color & color) {
  return new (UseGC) Image (::ImageText(text, fontSize, color));
}

extern "C" Image * bg____ImageTextEx_STATIC_Font_const_char_X_float_float_Color(Font & font, const char * text, float fontSize, float spacing, Color & tint) {
  return new (UseGC) Image (::ImageTextEx(font, text, fontSize, spacing, tint));
}

extern "C" Image * bg____GenImageColor_STATIC_int_int_Color(int width, int height, Color & color) {
  return new (UseGC) Image (::GenImageColor(width, height, color));
}

extern "C" Image * bg____GenImageGradientV_STATIC_int_int_Color_Color(int width, int height, Color & top, Color & bottom) {
  return new (UseGC) Image (::GenImageGradientV(width, height, top, bottom));
}

extern "C" Image * bg____GenImageGradientH_STATIC_int_int_Color_Color(int width, int height, Color & left, Color & right) {
  return new (UseGC) Image (::GenImageGradientH(width, height, left, right));
}

extern "C" Image * bg____GenImageGradientRadial_STATIC_int_int_float_Color_Color(int width, int height, float density, Color & inner, Color & outer) {
  return new (UseGC) Image (::GenImageGradientRadial(width, height, density, inner, outer));
}

extern "C" Image * bg____GenImageChecked_STATIC_int_int_int_int_Color_Color(int width, int height, int checksX, int checksY, Color & col1, Color & col2) {
  return new (UseGC) Image (::GenImageChecked(width, height, checksX, checksY, col1, col2));
}

extern "C" Image * bg____GenImageWhiteNoise_STATIC_int_int_float(int width, int height, float factor) {
  return new (UseGC) Image (::GenImageWhiteNoise(width, height, factor));
}

extern "C" Image * bg____GenImagePerlinNoise_STATIC_int_int_int_int_float(int width, int height, int offsetX, int offsetY, float scale) {
  return new (UseGC) Image (::GenImagePerlinNoise(width, height, offsetX, offsetY, scale));
}

extern "C" Image * bg____GenImageCellular_STATIC_int_int_int(int width, int height, int tileSize) {
  return new (UseGC) Image (::GenImageCellular(width, height, tileSize));
}

extern "C" Font * bg____GetFontDefault_STATIC_() {
  return new (UseGC) Font (::GetFontDefault());
}

extern "C" Font * bg____LoadFont_STATIC_const_char_X(const char * fileName) {
  return new (UseGC) Font (::LoadFont(fileName));
}

extern "C" Font * bg____LoadFontEx_STATIC_const_char_X_int_int_X_int(const char * fileName, int fontSize, int * fontChars, int charsCount) {
  return new (UseGC) Font (::LoadFontEx(fileName, fontSize, fontChars, charsCount));
}

extern "C" Font * bg____LoadFontFromImage_STATIC_Image_Color_int(Image & image, Color & key, int firstChar) {
  return new (UseGC) Font (::LoadFontFromImage(image, key, firstChar));
}

extern "C" Image * bg____GenImageFontAtlas_STATIC_CharInfo_X_int_int_int_int(CharInfo * chars, int charsCount, int fontSize, int padding, int packMethod) {
  return new (UseGC) Image (::GenImageFontAtlas(chars, charsCount, fontSize, padding, packMethod));
}

extern "C" Vector2 * bg____MeasureTextEx_STATIC_Font_const_char_X_float_float(Font & font, const char * text, float fontSize, float spacing) {
  return new (UseGC) Vector2 (::MeasureTextEx(font, text, fontSize, spacing));
}

extern "C" Model * bg____LoadModel_STATIC_const_char_X(const char * fileName) {
  return new (UseGC) Model (::LoadModel(fileName));
}

extern "C" Model * bg____LoadModelFromMesh_STATIC_Mesh(Mesh & mesh) {
  return new (UseGC) Model (::LoadModelFromMesh(mesh));
}

extern "C" Material * bg____LoadMaterialDefault_STATIC_() {
  return new (UseGC) Material (::LoadMaterialDefault());
}

extern "C" Mesh * bg____GenMeshPoly_STATIC_int_float(int sides, float radius) {
  return new (UseGC) Mesh (::GenMeshPoly(sides, radius));
}

extern "C" Mesh * bg____GenMeshPlane_STATIC_float_float_int_int(float width, float length, int resX, int resZ) {
  return new (UseGC) Mesh (::GenMeshPlane(width, length, resX, resZ));
}

extern "C" Mesh * bg____GenMeshCube_STATIC_float_float_float(float width, float height, float length) {
  return new (UseGC) Mesh (::GenMeshCube(width, height, length));
}

extern "C" Mesh * bg____GenMeshSphere_STATIC_float_int_int(float radius, int rings, int slices) {
  return new (UseGC) Mesh (::GenMeshSphere(radius, rings, slices));
}

extern "C" Mesh * bg____GenMeshHemiSphere_STATIC_float_int_int(float radius, int rings, int slices) {
  return new (UseGC) Mesh (::GenMeshHemiSphere(radius, rings, slices));
}

extern "C" Mesh * bg____GenMeshCylinder_STATIC_float_float_int(float radius, float height, int slices) {
  return new (UseGC) Mesh (::GenMeshCylinder(radius, height, slices));
}

extern "C" Mesh * bg____GenMeshTorus_STATIC_float_float_int_int(float radius, float size, int radSeg, int sides) {
  return new (UseGC) Mesh (::GenMeshTorus(radius, size, radSeg, sides));
}

extern "C" Mesh * bg____GenMeshKnot_STATIC_float_float_int_int(float radius, float size, int radSeg, int sides) {
  return new (UseGC) Mesh (::GenMeshKnot(radius, size, radSeg, sides));
}

extern "C" Mesh * bg____GenMeshHeightmap_STATIC_Image_Vector3(Image & heightmap, Vector3 & size) {
  return new (UseGC) Mesh (::GenMeshHeightmap(heightmap, size));
}

extern "C" Mesh * bg____GenMeshCubicmap_STATIC_Image_Vector3(Image & cubicmap, Vector3 & cubeSize) {
  return new (UseGC) Mesh (::GenMeshCubicmap(cubicmap, cubeSize));
}

extern "C" BoundingBox * bg____MeshBoundingBox_STATIC_Mesh(Mesh & mesh) {
  return new (UseGC) BoundingBox (::MeshBoundingBox(mesh));
}

extern "C" RayHitInfo * bg____GetCollisionRayModel_STATIC_Ray_Model_X(Ray & ray, Model * model) {
  return new (UseGC) RayHitInfo (::GetCollisionRayModel(ray, model));
}

extern "C" RayHitInfo * bg____GetCollisionRayTriangle_STATIC_Ray_Vector3_Vector3_Vector3(Ray & ray, Vector3 & p1, Vector3 & p2, Vector3 & p3) {
  return new (UseGC) RayHitInfo (::GetCollisionRayTriangle(ray, p1, p2, p3));
}

extern "C" RayHitInfo * bg____GetCollisionRayGround_STATIC_Ray_float(Ray & ray, float groundHeight) {
  return new (UseGC) RayHitInfo (::GetCollisionRayGround(ray, groundHeight));
}

extern "C" Shader * bg____LoadShader_STATIC_const_char_X_const_char_X(const char * vsFileName, const char * fsFileName) {
  return new (UseGC) Shader (::LoadShader(vsFileName, fsFileName));
}

extern "C" Shader * bg____LoadShaderCode_STATIC_char_X_char_X(char * vsCode, char * fsCode) {
  return new (UseGC) Shader (::LoadShaderCode(vsCode, fsCode));
}

extern "C" Shader * bg____GetShaderDefault_STATIC_() {
  return new (UseGC) Shader (::GetShaderDefault());
}

extern "C" Texture2D * bg____GetTextureDefault_STATIC_() {
  return new (UseGC) Texture2D (::GetTextureDefault());
}

extern "C" Matrix * bg____GetMatrixModelview_STATIC_() {
  return new (UseGC) Matrix (::GetMatrixModelview());
}

extern "C" Texture2D * bg____GenTextureCubemap_STATIC_Shader_Texture2D_int(Shader & shader, Texture2D & skyHDR, int size) {
  return new (UseGC) Texture2D (::GenTextureCubemap(shader, skyHDR, size));
}

extern "C" Texture2D * bg____GenTextureIrradiance_STATIC_Shader_Texture2D_int(Shader & shader, Texture2D & cubemap, int size) {
  return new (UseGC) Texture2D (::GenTextureIrradiance(shader, cubemap, size));
}

extern "C" Texture2D * bg____GenTexturePrefilter_STATIC_Shader_Texture2D_int(Shader & shader, Texture2D & cubemap, int size) {
  return new (UseGC) Texture2D (::GenTexturePrefilter(shader, cubemap, size));
}

extern "C" Texture2D * bg____GenTextureBRDF_STATIC_Shader_int(Shader & shader, int size) {
  return new (UseGC) Texture2D (::GenTextureBRDF(shader, size));
}

extern "C" Wave * bg____LoadWave_STATIC_const_char_X(const char * fileName) {
  return new (UseGC) Wave (::LoadWave(fileName));
}

extern "C" Wave * bg____LoadWaveEx_STATIC_void_X_int_int_int_int(void * data, int sampleCount, int sampleRate, int sampleSize, int channels) {
  return new (UseGC) Wave (::LoadWaveEx(data, sampleCount, sampleRate, sampleSize, channels));
}

extern "C" Sound * bg____LoadSound_STATIC_const_char_X(const char * fileName) {
  return new (UseGC) Sound (::LoadSound(fileName));
}

extern "C" Sound * bg____LoadSoundFromWave_STATIC_Wave(Wave & wave) {
  return new (UseGC) Sound (::LoadSoundFromWave(wave));
}

extern "C" Wave * bg____WaveCopy_STATIC_Wave(Wave & wave) {
  return new (UseGC) Wave (::WaveCopy(wave));
}

extern "C" AudioStream * bg____InitAudioStream_STATIC_unsigned_int_unsigned_int_unsigned_int(unsigned int sampleRate, unsigned int sampleSize, unsigned int channels) {
  return new (UseGC) AudioStream (::InitAudioStream(sampleRate, sampleSize, channels));
}

extern "C" Font * bg____GuiGetFont_STATIC_() {
  return new (UseGC) Font (::GuiGetFont());
}

extern "C" Rectangle * bg____GuiScrollPanel_STATIC_Rectangle_Rectangle_Vector2_X(Rectangle & bounds, Rectangle & content, Vector2 * scroll) {
  return new (UseGC) Rectangle (::GuiScrollPanel(bounds, content, scroll));
}

extern "C" Vector2 * bg____GuiGrid_STATIC_Rectangle_float_int(Rectangle & bounds, float spacing, int subdivs) {
  return new (UseGC) Vector2 (::GuiGrid(bounds, spacing, subdivs));
}

extern "C" Color * bg____GuiColorPicker_STATIC_Rectangle_Color(Rectangle & bounds, Color & color) {
  return new (UseGC) Color (::GuiColorPicker(bounds, color));
}

extern "C" int bg______sputc_STATIC_int_FILE_X(int _c, FILE * _p) {
  return ::__sputc(_c, _p);
}

extern "C" off_t * bg____ftello_STATIC_FILE_X(FILE * __stream) {
  return new (UseGC) off_t (::ftello(__stream));
}

extern "C" char * bg______libcpp_strchr_STATIC_const_char_X_int(const char * __s, int __c) {
  return ::__libcpp_strchr(__s, __c);
}

extern "C" const char * bg____strchr_STATIC_const_char_X_int(const char * __s, int __c) {
  return ::strchr(__s, __c);
}

extern "C" char * bg____strchr_STATIC_char_X_int(char * __s, int __c) {
  return ::strchr(__s, __c);
}

extern "C" char * bg______libcpp_strpbrk_STATIC_const_char_X_const_char_X(const char * __s1, const char * __s2) {
  return ::__libcpp_strpbrk(__s1, __s2);
}

extern "C" const char * bg____strpbrk_STATIC_const_char_X_const_char_X(const char * __s1, const char * __s2) {
  return ::strpbrk(__s1, __s2);
}

extern "C" char * bg____strpbrk_STATIC_char_X_const_char_X(char * __s1, const char * __s2) {
  return ::strpbrk(__s1, __s2);
}

extern "C" char * bg______libcpp_strrchr_STATIC_const_char_X_int(const char * __s, int __c) {
  return ::__libcpp_strrchr(__s, __c);
}

extern "C" const char * bg____strrchr_STATIC_const_char_X_int(const char * __s, int __c) {
  return ::strrchr(__s, __c);
}

extern "C" char * bg____strrchr_STATIC_char_X_int(char * __s, int __c) {
  return ::strrchr(__s, __c);
}

extern "C" void * bg______libcpp_memchr_STATIC_const_void_X_int_size_t(const void * __s, int __c, size_t __n) {
  return ::__libcpp_memchr(__s, __c, __n);
}

extern "C" const void * bg____memchr_STATIC_const_void_X_int_size_t(const void * __s, int __c, size_t __n) {
  return ::memchr(__s, __c, __n);
}

extern "C" void * bg____memchr_STATIC_void_X_int_size_t(void * __s, int __c, size_t __n) {
  return ::memchr(__s, __c, __n);
}

extern "C" char * bg______libcpp_strstr_STATIC_const_char_X_const_char_X(const char * __s1, const char * __s2) {
  return ::__libcpp_strstr(__s1, __s2);
}

extern "C" const char * bg____strstr_STATIC_const_char_X_const_char_X(const char * __s1, const char * __s2) {
  return ::strstr(__s1, __s2);
}

extern "C" char * bg____strstr_STATIC_char_X_const_char_X(char * __s1, const char * __s2) {
  return ::strstr(__s1, __s2);
}

extern "C" __uint16_t * bg_____OSSwapInt16_STATIC___uint16_t(__uint16_t & _data) {
  return new (UseGC) __uint16_t (::_OSSwapInt16(_data));
}

extern "C" __uint32_t * bg_____OSSwapInt32_STATIC___uint32_t(__uint32_t & _data) {
  return new (UseGC) __uint32_t (::_OSSwapInt32(_data));
}

extern "C" __uint64_t * bg_____OSSwapInt64_STATIC___uint64_t(__uint64_t & _data) {
  return new (UseGC) __uint64_t (::_OSSwapInt64(_data));
}

extern "C" pid_t * bg____wait_STATIC_int_X(int * unnamed_arg_0) {
  return new (UseGC) pid_t (::wait(unnamed_arg_0));
}

extern "C" pid_t * bg____waitpid_STATIC_pid_t_int_X_int(pid_t & unnamed_arg_0, int * unnamed_arg_1, int unnamed_arg_2) {
  return new (UseGC) pid_t (::waitpid(unnamed_arg_0, unnamed_arg_1, unnamed_arg_2));
}

extern "C" long double * bg____strtold_STATIC_const_char_X_char_XX(const char * unnamed_arg_0, char ** unnamed_arg_1) {
  return new (UseGC) long double (::strtold(unnamed_arg_0, unnamed_arg_1));
}

extern "C" long bg____abs_STATIC_long(long __x) {
  return ::abs(__x);
}

extern "C" long long bg____abs_STATIC_long_long(long long __x) {
  return ::abs(__x);
}

extern "C" Vector3 * bg____ConvertHSVtoRGB_STATIC_Vector3(Vector3 & hsv) {
  return new (UseGC) Vector3 (::ConvertHSVtoRGB(hsv));
}

extern "C" Vector3 * bg____ConvertRGBtoHSV_STATIC_Vector3(Vector3 & rgb) {
  return new (UseGC) Vector3 (::ConvertRGBtoHSV(rgb));
}

extern "C" int bg____GetTextWidth_STATIC_const_char_X(const char * text) {
  return ::GetTextWidth(text);
}

extern "C" Rectangle * bg____GetTextBounds_STATIC_int_Rectangle(int control, Rectangle & bounds) {
  return new (UseGC) Rectangle (::GetTextBounds(control, bounds));
}

extern "C" const char * bg____GetTextIcon_STATIC_const_char_X_int_X(const char * text, int * iconId) {
  return ::GetTextIcon(text, iconId);
}

extern "C" void bg____GuiDrawText_STATIC_const_char_X_Rectangle_int_Color(const char * text, Rectangle & bounds, int alignment, Color & tint) {
  ::GuiDrawText(text, bounds, alignment, tint);
}

extern "C" const char ** bg____GuiTextSplit_STATIC_const_char_X_int_X_int_X(const char * text, int * count, int * textRow) {
  return ::GuiTextSplit(text, count, textRow);
}

extern "C" Color * bg____GuiColorPanelEx_STATIC_Rectangle_Color_float(Rectangle & bounds, Color & color, float hue) {
  return new (UseGC) Color (::GuiColorPanelEx(bounds, color, hue));
}

extern "C" Color * bg____GuiColorPanel_STATIC_Rectangle_Color(Rectangle & bounds, Color & color) {
  return new (UseGC) Color (::GuiColorPanel(bounds, color));
}

