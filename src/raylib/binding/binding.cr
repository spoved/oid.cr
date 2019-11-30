module RayLib
  
  # Native bindings.  Mostly generated.
  lib Binding
    # Container for string data.
    struct CrystalString
      ptr : LibC::Char*
      size : LibC::Int
    end
  
    # Container for a `Proc`
    struct CrystalProc
      ptr : Void*
      context : Void*
    end
  
    # Container for raw memory-data.  The `ptr` could be anything.
    struct CrystalSlice
      ptr : Void*
      size : LibC::Int
    end
  end
  
  # Helpers for bindings.  Required.
  module BindgenHelper
    # Wraps `Proc` to a `Binding::CrystalProc`, which can then passed on to C++.
    def self.wrap_proc(proc : Proc)
      Binding::CrystalProc.new(
        ptr: proc.pointer,
        context: proc.closure_data,
      )
    end
  
    # Wraps `Proc` to a `Binding::CrystalProc`, which can then passed on to C++.
    # `Nil` version, returns a null-proc.
    def self.wrap_proc(nothing : Nil)
      Binding::CrystalProc.new(
        ptr: Pointer(Void).null,
        context: Pointer(Void).null,
      )
    end
  
    # Wraps a *list* into a container *wrapper*, if it's not already one.
    macro wrap_container(wrapper, list)
      %instance = {{ list }}
      if %instance.is_a?({{ wrapper }})
        %instance
      else
        {{wrapper}}.new.concat(%instance)
      end
    end
  
    # Wrapper for an instantiated, sequential container type.
    #
    # This offers (almost) all read-only methods known from `Array`.
    # Additionally, there's `#<<`.  Other than that, the container type is not
    # meant to be used for storage, but for data transmission between the C++
    # and the Crystal world.  Don't let that discourage you though.
    abstract class SequentialContainer(T)
      include Indexable(T)
  
      # `#unsafe_at` and `#size` will be implemented by the wrapper class.
  
      # Adds an element at the end.  Implemented by the wrapper.
      abstract def push(value)
  
      # Adds *element* at the end of the container.
      def <<(value : T) : self
        push(value)
        self
      end
  
      # Adds all *elements* at the end of the container, retaining their order.
      def concat(values : Enumerable(T)) : self
        values.each { |v| push(v) }
        self
      end
  
      def to_s(io)
        to_a.to_s(io)
      end
  
      def inspect(io)
        io << "<Wrapped "
        to_a.inspect(io)
        io << ">"
      end
    end
  end
  
  @[Link(ldflags: "-lraylib")]
  lib Binding
    alias Camera = Void
    alias TextureCubemap = Void
    alias MusicData = Void
    struct Color
      r : UInt8
      g : UInt8
      b : UInt8
      a : UInt8
    end
    struct Vector2
      x : Float32
      y : Float32
    end
    struct Vector3
      x : Float32
      y : Float32
      z : Float32
    end
    struct Vector4
      x : Float32
      y : Float32
      z : Float32
      w : Float32
    end
    struct Matrix
      m0 : Float32
      m4 : Float32
      m8 : Float32
      m12 : Float32
      m1 : Float32
      m5 : Float32
      m9 : Float32
      m13 : Float32
      m2 : Float32
      m6 : Float32
      m10 : Float32
      m14 : Float32
      m3 : Float32
      m7 : Float32
      m11 : Float32
      m15 : Float32
    end
    struct Rectangle
      x : Float32
      y : Float32
      width : Float32
      height : Float32
    end
    struct Image
      data : Void*
      width : Int32
      height : Int32
      mipmaps : Int32
      format : Int32
    end
    struct Texture2D
      id : Int32
      width : Int32
      height : Int32
      mipmaps : Int32
      format : Int32
    end
    struct RenderTexture2D
      id : Int32
      texture : Texture2D
      depth : Texture2D
      depth_texture : Bool
    end
    struct NPatchInfo
      source_rec : Rectangle
      left : Int32
      top : Int32
      right : Int32
      bottom : Int32
      type : Int32
    end
    struct CharInfo
      value : Int32
      rec : Rectangle
      offset_x : Int32
      offset_y : Int32
      advance_x : Int32
      data : UInt8
    end
    struct Font
      texture : Texture2D
      base_size : Int32
      chars_count : Int32
      chars : CharInfo
    end
    struct Camera3D
      position : Vector3
      target : Vector3
      up : Vector3
      fovy : Float32
      type : Int32
    end
    struct Camera2D
      offset : Vector2
      target : Vector2
      rotation : Float32
      zoom : Float32
    end
    struct Mesh
      vertex_count : Int32
      triangle_count : Int32
      vertices : Float32
      texcoords : Float32
      texcoords2 : Float32
      normals : Float32
      tangents : Float32
      colors : UInt8
      indices : UInt16
      anim_vertices : Float32
      anim_normals : Float32
      bone_ids : Int32
      bone_weights : Float32
      vao_id : Int32
      vbo_id : LibC::UInt[7]
    end
    struct Shader
      id : Int32
      locs : LibC::Int[32]
    end
    struct MaterialMap
      texture : Texture2D
      color : Color
      value : Float32
    end
    struct Material
      shader : Shader
      maps : MaterialMap [12]
      params : Float32
    end
    struct Transform
      translation : Vector3
      rotation : Vector4
      scale : Vector3
    end
    struct BoneInfo
      name : LibC::Char[32]
      parent : Int32
    end
    struct Model
      transform : Matrix
      mesh_count : Int32
      meshes : Mesh
      material_count : Int32
      materials : Material
      mesh_material : Int32
      bone_count : Int32
      bones : BoneInfo
      bind_pose : Transform
    end
    struct ModelAnimation
      bone_count : Int32
      bones : BoneInfo
      frame_count : Int32
      frame_poses : Transform
    end
    struct Ray
      position : Vector3
      direction : Vector3
    end
    struct RayHitInfo
      hit : Bool
      distance : Float32
      position : Vector3
      normal : Vector3
    end
    struct BoundingBox
      min : Vector3
      max : Vector3
    end
    struct Wave
      sample_count : Int32
      sample_rate : Int32
      sample_size : Int32
      channels : Int32
      data : Void*
    end
    struct Sound
      audio_buffer : Void*
      source : Int32
      buffer : Int32
      format : Int32
    end
    struct AudioStream
      sample_rate : Int32
      sample_size : Int32
      channels : Int32
      audio_buffer : Void*
      format : Int32
      source : Int32
      buffers : LibC::UInt[2]
    end
    struct VrDeviceInfo
      h_resolution : Int32
      v_resolution : Int32
      h_screen_size : Float32
      v_screen_size : Float32
      v_screen_center : Float32
      eye_to_screen_distance : Float32
      lens_separation_distance : Float32
      interpupillary_distance : Float32
      lens_distortion_values : LibC::Float[4]
      chroma_ab_correction : LibC::Float[4]
    end
    fun bg_Color__CONSTRUCT_() : Color*
    fun bg_Vector2__CONSTRUCT_() : Vector2*
    fun bg_Vector3__CONSTRUCT_() : Vector3*
    fun bg_Vector4__CONSTRUCT_() : Vector4*
    fun bg_Matrix__CONSTRUCT_() : Matrix*
    fun bg_Rectangle__CONSTRUCT_() : Rectangle*
    fun bg_Image__CONSTRUCT_() : Image*
    fun bg_Texture2D__CONSTRUCT_() : Texture2D*
    fun bg_RenderTexture2D__CONSTRUCT_() : RenderTexture2D*
    fun bg_NPatchInfo__CONSTRUCT_() : NPatchInfo*
    fun bg_CharInfo__CONSTRUCT_() : CharInfo*
    fun bg_Font__CONSTRUCT_() : Font*
    fun bg_Camera3D__CONSTRUCT_() : Camera3D*
    fun bg_Camera2D__CONSTRUCT_() : Camera2D*
    fun bg_Mesh__CONSTRUCT_() : Mesh*
    fun bg_Shader__CONSTRUCT_() : Shader*
    fun bg_MaterialMap__CONSTRUCT_() : MaterialMap*
    fun bg_Material__CONSTRUCT_() : Material*
    fun bg_Transform__CONSTRUCT_() : Transform*
    fun bg_BoneInfo__CONSTRUCT_() : BoneInfo*
    fun bg_Model__CONSTRUCT_() : Model*
    fun bg_ModelAnimation__CONSTRUCT_() : ModelAnimation*
    fun bg_Ray__CONSTRUCT_() : Ray*
    fun bg_RayHitInfo__CONSTRUCT_() : RayHitInfo*
    fun bg_BoundingBox__CONSTRUCT_() : BoundingBox*
    fun bg_Wave__CONSTRUCT_() : Wave*
    fun bg_Sound__CONSTRUCT_() : Sound*
    fun bg_AudioStream__CONSTRUCT_() : AudioStream*
    fun bg_VrDeviceInfo__CONSTRUCT_() : VrDeviceInfo*
    fun bg____InitWindow_STATIC_int_int_const_char_X = InitWindow(width : Int32, height : Int32, title : UInt8*) : Void
    fun bg____WindowShouldClose_STATIC_ = WindowShouldClose() : Bool
    fun bg____CloseWindow_STATIC_ = CloseWindow() : Void
    fun bg____IsWindowReady_STATIC_ = IsWindowReady() : Bool
    fun bg____IsWindowMinimized_STATIC_ = IsWindowMinimized() : Bool
    fun bg____IsWindowResized_STATIC_ = IsWindowResized() : Bool
    fun bg____IsWindowHidden_STATIC_ = IsWindowHidden() : Bool
    fun bg____ToggleFullscreen_STATIC_ = ToggleFullscreen() : Void
    fun bg____UnhideWindow_STATIC_ = UnhideWindow() : Void
    fun bg____HideWindow_STATIC_ = HideWindow() : Void
    fun bg____SetWindowIcon_STATIC_Image = SetWindowIcon(image : Image) : Void
    fun bg____SetWindowTitle_STATIC_const_char_X = SetWindowTitle(title : UInt8*) : Void
    fun bg____SetWindowPosition_STATIC_int_int = SetWindowPosition(x : Int32, y : Int32) : Void
    fun bg____SetWindowMonitor_STATIC_int = SetWindowMonitor(monitor : Int32) : Void
    fun bg____SetWindowMinSize_STATIC_int_int = SetWindowMinSize(width : Int32, height : Int32) : Void
    fun bg____SetWindowSize_STATIC_int_int = SetWindowSize(width : Int32, height : Int32) : Void
    fun bg____GetWindowHandle_STATIC_ = GetWindowHandle() : Void*
    fun bg____GetScreenWidth_STATIC_ = GetScreenWidth() : Int32
    fun bg____GetScreenHeight_STATIC_ = GetScreenHeight() : Int32
    fun bg____GetMonitorCount_STATIC_ = GetMonitorCount() : Int32
    fun bg____GetMonitorWidth_STATIC_int = GetMonitorWidth(monitor : Int32) : Int32
    fun bg____GetMonitorHeight_STATIC_int = GetMonitorHeight(monitor : Int32) : Int32
    fun bg____GetMonitorPhysicalWidth_STATIC_int = GetMonitorPhysicalWidth(monitor : Int32) : Int32
    fun bg____GetMonitorPhysicalHeight_STATIC_int = GetMonitorPhysicalHeight(monitor : Int32) : Int32
    fun bg____GetMonitorName_STATIC_int = GetMonitorName(monitor : Int32) : UInt8*
    fun bg____GetClipboardText_STATIC_ = GetClipboardText() : UInt8*
    fun bg____SetClipboardText_STATIC_const_char_X = SetClipboardText(text : UInt8*) : Void
    fun bg____ShowCursor_STATIC_ = ShowCursor() : Void
    fun bg____HideCursor_STATIC_ = HideCursor() : Void
    fun bg____IsCursorHidden_STATIC_ = IsCursorHidden() : Bool
    fun bg____EnableCursor_STATIC_ = EnableCursor() : Void
    fun bg____DisableCursor_STATIC_ = DisableCursor() : Void
    fun bg____ClearBackground_STATIC_Color = ClearBackground(color : Color) : Void
    fun bg____BeginDrawing_STATIC_ = BeginDrawing() : Void
    fun bg____EndDrawing_STATIC_ = EndDrawing() : Void
    fun bg____BeginMode2D_STATIC_Camera2D = BeginMode2D(camera : Camera2D) : Void
    fun bg____EndMode2D_STATIC_ = EndMode2D() : Void
    fun bg____BeginMode3D_STATIC_Camera3D = BeginMode3D(camera : Camera3D) : Void
    fun bg____EndMode3D_STATIC_ = EndMode3D() : Void
    fun bg____BeginTextureMode_STATIC_RenderTexture2D = BeginTextureMode(target : RenderTexture2D) : Void
    fun bg____EndTextureMode_STATIC_ = EndTextureMode() : Void
    fun bg____GetMouseRay_STATIC_Vector2_Camera = GetMouseRay(mouse_position : Vector2, camera : Camera*) : Ray
    fun bg____GetWorldToScreen_STATIC_Vector3_Camera = GetWorldToScreen(position : Vector3, camera : Camera*) : Vector2
    fun bg____GetCameraMatrix_STATIC_Camera = GetCameraMatrix(camera : Camera*) : Matrix
    fun bg____SetTargetFPS_STATIC_int = SetTargetFPS(fps : Int32) : Void
    fun bg____GetFPS_STATIC_ = GetFPS() : Int32
    fun bg____GetFrameTime_STATIC_ = GetFrameTime() : Float32
    fun bg____GetTime_STATIC_ = GetTime() : Float64
    fun bg____ColorToInt_STATIC_Color = ColorToInt(color : Color) : Int32
    fun bg____ColorNormalize_STATIC_Color = ColorNormalize(color : Color) : Vector4
    fun bg____ColorToHSV_STATIC_Color = ColorToHSV(color : Color) : Vector3
    fun bg____ColorFromHSV_STATIC_Vector3 = ColorFromHSV(hsv : Vector3) : Color
    fun bg____GetColor_STATIC_int = GetColor(hex_value : Int32) : Color
    fun bg____Fade_STATIC_Color_float = Fade(color : Color, alpha : Float32) : Color
    fun bg____SetConfigFlags_STATIC_unsigned_char = SetConfigFlags(flags : UInt8) : Void
    fun bg____SetTraceLogLevel_STATIC_int = SetTraceLogLevel(log_type : Int32) : Void
    fun bg____SetTraceLogExit_STATIC_int = SetTraceLogExit(log_type : Int32) : Void
    fun bg____TraceLog_STATIC_int_const_char_X_ = TraceLog(log_type : Int32, text : UInt8*, ...) : Void
    fun bg____TakeScreenshot_STATIC_const_char_X = TakeScreenshot(file_name : UInt8*) : Void
    fun bg____GetRandomValue_STATIC_int_int = GetRandomValue(min : Int32, max : Int32) : Int32
    fun bg____FileExists_STATIC_const_char_X = FileExists(file_name : UInt8*) : Bool
    fun bg____IsFileExtension_STATIC_const_char_X_const_char_X = IsFileExtension(file_name : UInt8*, ext : UInt8*) : Bool
    fun bg____GetExtension_STATIC_const_char_X = GetExtension(file_name : UInt8*) : UInt8*
    fun bg____GetFileName_STATIC_const_char_X = GetFileName(file_path : UInt8*) : UInt8*
    fun bg____GetFileNameWithoutExt_STATIC_const_char_X = GetFileNameWithoutExt(file_path : UInt8*) : UInt8*
    fun bg____GetDirectoryPath_STATIC_const_char_X = GetDirectoryPath(file_name : UInt8*) : UInt8*
    fun bg____GetWorkingDirectory_STATIC_ = GetWorkingDirectory() : UInt8*
    fun bg____GetDirectoryFiles_STATIC_const_char_X_int_X = GetDirectoryFiles(dir_path : UInt8*, count : Int32*) : UInt8**
    fun bg____ClearDirectoryFiles_STATIC_ = ClearDirectoryFiles() : Void
    fun bg____ChangeDirectory_STATIC_const_char_X = ChangeDirectory(dir : UInt8*) : Bool
    fun bg____IsFileDropped_STATIC_ = IsFileDropped() : Bool
    fun bg____GetDroppedFiles_STATIC_int_X = GetDroppedFiles(count : Int32*) : UInt8**
    fun bg____ClearDroppedFiles_STATIC_ = ClearDroppedFiles() : Void
    fun bg____GetFileModTime_STATIC_const_char_X = GetFileModTime(file_name : UInt8*) : LibC::Long
    fun bg____StorageSaveValue_STATIC_int_int = StorageSaveValue(position : Int32, value : Int32) : Void
    fun bg____StorageLoadValue_STATIC_int = StorageLoadValue(position : Int32) : Int32
    fun bg____OpenURL_STATIC_const_char_X = OpenURL(url : UInt8*) : Void
    fun bg____IsKeyPressed_STATIC_int = IsKeyPressed(key : Int32) : Bool
    fun bg____IsKeyDown_STATIC_int = IsKeyDown(key : Int32) : Bool
    fun bg____IsKeyReleased_STATIC_int = IsKeyReleased(key : Int32) : Bool
    fun bg____IsKeyUp_STATIC_int = IsKeyUp(key : Int32) : Bool
    fun bg____GetKeyPressed_STATIC_ = GetKeyPressed() : Int32
    fun bg____SetExitKey_STATIC_int = SetExitKey(key : Int32) : Void
    fun bg____IsGamepadAvailable_STATIC_int = IsGamepadAvailable(gamepad : Int32) : Bool
    fun bg____IsGamepadName_STATIC_int_const_char_X = IsGamepadName(gamepad : Int32, name : UInt8*) : Bool
    fun bg____GetGamepadName_STATIC_int = GetGamepadName(gamepad : Int32) : UInt8*
    fun bg____IsGamepadButtonPressed_STATIC_int_int = IsGamepadButtonPressed(gamepad : Int32, button : Int32) : Bool
    fun bg____IsGamepadButtonDown_STATIC_int_int = IsGamepadButtonDown(gamepad : Int32, button : Int32) : Bool
    fun bg____IsGamepadButtonReleased_STATIC_int_int = IsGamepadButtonReleased(gamepad : Int32, button : Int32) : Bool
    fun bg____IsGamepadButtonUp_STATIC_int_int = IsGamepadButtonUp(gamepad : Int32, button : Int32) : Bool
    fun bg____GetGamepadButtonPressed_STATIC_ = GetGamepadButtonPressed() : Int32
    fun bg____GetGamepadAxisCount_STATIC_int = GetGamepadAxisCount(gamepad : Int32) : Int32
    fun bg____GetGamepadAxisMovement_STATIC_int_int = GetGamepadAxisMovement(gamepad : Int32, axis : Int32) : Float32
    fun bg____IsMouseButtonPressed_STATIC_int = IsMouseButtonPressed(button : Int32) : Bool
    fun bg____IsMouseButtonDown_STATIC_int = IsMouseButtonDown(button : Int32) : Bool
    fun bg____IsMouseButtonReleased_STATIC_int = IsMouseButtonReleased(button : Int32) : Bool
    fun bg____IsMouseButtonUp_STATIC_int = IsMouseButtonUp(button : Int32) : Bool
    fun bg____GetMouseX_STATIC_ = GetMouseX() : Int32
    fun bg____GetMouseY_STATIC_ = GetMouseY() : Int32
    fun bg____GetMousePosition_STATIC_ = GetMousePosition() : Vector2
    fun bg____SetMousePosition_STATIC_int_int = SetMousePosition(x : Int32, y : Int32) : Void
    fun bg____SetMouseOffset_STATIC_int_int = SetMouseOffset(offset_x : Int32, offset_y : Int32) : Void
    fun bg____SetMouseScale_STATIC_float_float = SetMouseScale(scale_x : Float32, scale_y : Float32) : Void
    fun bg____GetMouseWheelMove_STATIC_ = GetMouseWheelMove() : Int32
    fun bg____GetTouchX_STATIC_ = GetTouchX() : Int32
    fun bg____GetTouchY_STATIC_ = GetTouchY() : Int32
    fun bg____GetTouchPosition_STATIC_int = GetTouchPosition(index : Int32) : Vector2
    fun bg____SetGesturesEnabled_STATIC_unsigned_int = SetGesturesEnabled(gesture_flags : Int32) : Void
    fun bg____IsGestureDetected_STATIC_int = IsGestureDetected(gesture : Int32) : Bool
    fun bg____GetGestureDetected_STATIC_ = GetGestureDetected() : Int32
    fun bg____GetTouchPointsCount_STATIC_ = GetTouchPointsCount() : Int32
    fun bg____GetGestureHoldDuration_STATIC_ = GetGestureHoldDuration() : Float32
    fun bg____GetGestureDragVector_STATIC_ = GetGestureDragVector() : Vector2
    fun bg____GetGestureDragAngle_STATIC_ = GetGestureDragAngle() : Float32
    fun bg____GetGesturePinchVector_STATIC_ = GetGesturePinchVector() : Vector2
    fun bg____GetGesturePinchAngle_STATIC_ = GetGesturePinchAngle() : Float32
    fun bg____SetCameraMode_STATIC_Camera_int = SetCameraMode(camera : Camera*, mode : Int32) : Void
    fun bg____UpdateCamera_STATIC_Camera_X = UpdateCamera(camera : Camera*) : Void
    fun bg____SetCameraPanControl_STATIC_int = SetCameraPanControl(pan_key : Int32) : Void
    fun bg____SetCameraAltControl_STATIC_int = SetCameraAltControl(alt_key : Int32) : Void
    fun bg____SetCameraSmoothZoomControl_STATIC_int = SetCameraSmoothZoomControl(sz_key : Int32) : Void
    fun bg____SetCameraMoveControls_STATIC_int_int_int_int_int_int = SetCameraMoveControls(front_key : Int32, back_key : Int32, right_key : Int32, left_key : Int32, up_key : Int32, down_key : Int32) : Void
    fun bg____DrawPixel_STATIC_int_int_Color = DrawPixel(pos_x : Int32, pos_y : Int32, color : Color) : Void
    fun bg____DrawPixelV_STATIC_Vector2_Color = DrawPixelV(position : Vector2, color : Color) : Void
    fun bg____DrawLine_STATIC_int_int_int_int_Color = DrawLine(start_pos_x : Int32, start_pos_y : Int32, end_pos_x : Int32, end_pos_y : Int32, color : Color) : Void
    fun bg____DrawLineV_STATIC_Vector2_Vector2_Color = DrawLineV(start_pos : Vector2, end_pos : Vector2, color : Color) : Void
    fun bg____DrawLineEx_STATIC_Vector2_Vector2_float_Color = DrawLineEx(start_pos : Vector2, end_pos : Vector2, thick : Float32, color : Color) : Void
    fun bg____DrawLineBezier_STATIC_Vector2_Vector2_float_Color = DrawLineBezier(start_pos : Vector2, end_pos : Vector2, thick : Float32, color : Color) : Void
    fun bg____DrawLineStrip_STATIC_Vector2_X_int_Color = DrawLineStrip(points : Vector2*, num_points : Int32, color : Color) : Void
    fun bg____DrawCircle_STATIC_int_int_float_Color = DrawCircle(center_x : Int32, center_y : Int32, radius : Float32, color : Color) : Void
    fun bg____DrawCircleSector_STATIC_Vector2_float_int_int_int_Color = DrawCircleSector(center : Vector2, radius : Float32, start_angle : Int32, end_angle : Int32, segments : Int32, color : Color) : Void
    fun bg____DrawCircleSectorLines_STATIC_Vector2_float_int_int_int_Color = DrawCircleSectorLines(center : Vector2, radius : Float32, start_angle : Int32, end_angle : Int32, segments : Int32, color : Color) : Void
    fun bg____DrawCircleGradient_STATIC_int_int_float_Color_Color = DrawCircleGradient(center_x : Int32, center_y : Int32, radius : Float32, color1 : Color, color2 : Color) : Void
    fun bg____DrawCircleV_STATIC_Vector2_float_Color = DrawCircleV(center : Vector2, radius : Float32, color : Color) : Void
    fun bg____DrawCircleLines_STATIC_int_int_float_Color = DrawCircleLines(center_x : Int32, center_y : Int32, radius : Float32, color : Color) : Void
    fun bg____DrawRing_STATIC_Vector2_float_float_int_int_int_Color = DrawRing(center : Vector2, inner_radius : Float32, outer_radius : Float32, start_angle : Int32, end_angle : Int32, segments : Int32, color : Color) : Void
    fun bg____DrawRingLines_STATIC_Vector2_float_float_int_int_int_Color = DrawRingLines(center : Vector2, inner_radius : Float32, outer_radius : Float32, start_angle : Int32, end_angle : Int32, segments : Int32, color : Color) : Void
    fun bg____DrawRectangle_STATIC_int_int_int_int_Color = DrawRectangle(pos_x : Int32, pos_y : Int32, width : Int32, height : Int32, color : Color) : Void
    fun bg____DrawRectangleV_STATIC_Vector2_Vector2_Color = DrawRectangleV(position : Vector2, size : Vector2, color : Color) : Void
    fun bg____DrawRectangleRec_STATIC_Rectangle_Color = DrawRectangleRec(rec : Rectangle, color : Color) : Void
    fun bg____DrawRectanglePro_STATIC_Rectangle_Vector2_float_Color = DrawRectanglePro(rec : Rectangle, origin : Vector2, rotation : Float32, color : Color) : Void
    fun bg____DrawRectangleGradientV_STATIC_int_int_int_int_Color_Color = DrawRectangleGradientV(pos_x : Int32, pos_y : Int32, width : Int32, height : Int32, color1 : Color, color2 : Color) : Void
    fun bg____DrawRectangleGradientH_STATIC_int_int_int_int_Color_Color = DrawRectangleGradientH(pos_x : Int32, pos_y : Int32, width : Int32, height : Int32, color1 : Color, color2 : Color) : Void
    fun bg____DrawRectangleGradientEx_STATIC_Rectangle_Color_Color_Color_Color = DrawRectangleGradientEx(rec : Rectangle, col1 : Color, col2 : Color, col3 : Color, col4 : Color) : Void
    fun bg____DrawRectangleLines_STATIC_int_int_int_int_Color = DrawRectangleLines(pos_x : Int32, pos_y : Int32, width : Int32, height : Int32, color : Color) : Void
    fun bg____DrawRectangleLinesEx_STATIC_Rectangle_int_Color = DrawRectangleLinesEx(rec : Rectangle, line_thick : Int32, color : Color) : Void
    fun bg____DrawRectangleRounded_STATIC_Rectangle_float_int_Color = DrawRectangleRounded(rec : Rectangle, roundness : Float32, segments : Int32, color : Color) : Void
    fun bg____DrawRectangleRoundedLines_STATIC_Rectangle_float_int_int_Color = DrawRectangleRoundedLines(rec : Rectangle, roundness : Float32, segments : Int32, line_thick : Int32, color : Color) : Void
    fun bg____DrawTriangle_STATIC_Vector2_Vector2_Vector2_Color = DrawTriangle(v1 : Vector2, v2 : Vector2, v3 : Vector2, color : Color) : Void
    fun bg____DrawTriangleLines_STATIC_Vector2_Vector2_Vector2_Color = DrawTriangleLines(v1 : Vector2, v2 : Vector2, v3 : Vector2, color : Color) : Void
    fun bg____DrawTriangleFan_STATIC_Vector2_X_int_Color = DrawTriangleFan(points : Vector2*, num_points : Int32, color : Color) : Void
    fun bg____DrawPoly_STATIC_Vector2_int_float_float_Color = DrawPoly(center : Vector2, sides : Int32, radius : Float32, rotation : Float32, color : Color) : Void
    fun bg____SetShapesTexture_STATIC_Texture2D_Rectangle = SetShapesTexture(texture : Texture2D, source : Rectangle) : Void
    fun bg____CheckCollisionRecs_STATIC_Rectangle_Rectangle = CheckCollisionRecs(rec1 : Rectangle, rec2 : Rectangle) : Bool
    fun bg____CheckCollisionCircles_STATIC_Vector2_float_Vector2_float = CheckCollisionCircles(center1 : Vector2, radius1 : Float32, center2 : Vector2, radius2 : Float32) : Bool
    fun bg____CheckCollisionCircleRec_STATIC_Vector2_float_Rectangle = CheckCollisionCircleRec(center : Vector2, radius : Float32, rec : Rectangle) : Bool
    fun bg____GetCollisionRec_STATIC_Rectangle_Rectangle = GetCollisionRec(rec1 : Rectangle, rec2 : Rectangle) : Rectangle
    fun bg____CheckCollisionPointRec_STATIC_Vector2_Rectangle = CheckCollisionPointRec(point : Vector2, rec : Rectangle) : Bool
    fun bg____CheckCollisionPointCircle_STATIC_Vector2_Vector2_float = CheckCollisionPointCircle(point : Vector2, center : Vector2, radius : Float32) : Bool
    fun bg____CheckCollisionPointTriangle_STATIC_Vector2_Vector2_Vector2_Vector2 = CheckCollisionPointTriangle(point : Vector2, p1 : Vector2, p2 : Vector2, p3 : Vector2) : Bool
    fun bg____LoadImage_STATIC_const_char_X = LoadImage(file_name : UInt8*) : Image
    fun bg____LoadImageEx_STATIC_Color_X_int_int = LoadImageEx(pixels : Color*, width : Int32, height : Int32) : Image
    fun bg____LoadImagePro_STATIC_void_X_int_int_int = LoadImagePro(data : Void*, width : Int32, height : Int32, format : Int32) : Image
    fun bg____LoadImageRaw_STATIC_const_char_X_int_int_int_int = LoadImageRaw(file_name : UInt8*, width : Int32, height : Int32, format : Int32, header_size : Int32) : Image
    fun bg____ExportImage_STATIC_Image_const_char_X = ExportImage(image : Image, file_name : UInt8*) : Void
    fun bg____ExportImageAsCode_STATIC_Image_const_char_X = ExportImageAsCode(image : Image, file_name : UInt8*) : Void
    fun bg____LoadTexture_STATIC_const_char_X = LoadTexture(file_name : UInt8*) : Texture2D
    fun bg____LoadTextureFromImage_STATIC_Image = LoadTextureFromImage(image : Image) : Texture2D
    fun bg____LoadTextureCubemap_STATIC_Image_int(image : Image, layout_type : Int32) : TextureCubemap*
    fun bg____LoadRenderTexture_STATIC_int_int = LoadRenderTexture(width : Int32, height : Int32) : RenderTexture2D
    fun bg____UnloadImage_STATIC_Image = UnloadImage(image : Image) : Void
    fun bg____UnloadTexture_STATIC_Texture2D = UnloadTexture(texture : Texture2D) : Void
    fun bg____UnloadRenderTexture_STATIC_RenderTexture2D = UnloadRenderTexture(target : RenderTexture2D) : Void
    fun bg____GetImageData_STATIC_Image = GetImageData(image : Image) : Color*
    fun bg____GetImageDataNormalized_STATIC_Image = GetImageDataNormalized(image : Image) : Vector4*
    fun bg____GetPixelDataSize_STATIC_int_int_int = GetPixelDataSize(width : Int32, height : Int32, format : Int32) : Int32
    fun bg____GetTextureData_STATIC_Texture2D = GetTextureData(texture : Texture2D) : Image
    fun bg____GetScreenData_STATIC_ = GetScreenData() : Image
    fun bg____UpdateTexture_STATIC_Texture2D_const_void_X = UpdateTexture(texture : Texture2D, pixels : Void*) : Void
    fun bg____ImageCopy_STATIC_Image = ImageCopy(image : Image) : Image
    fun bg____ImageToPOT_STATIC_Image_X_Color = ImageToPOT(image : Image*, fill_color : Color) : Void
    fun bg____ImageFormat_STATIC_Image_X_int = ImageFormat(image : Image*, new_format : Int32) : Void
    fun bg____ImageAlphaMask_STATIC_Image_X_Image = ImageAlphaMask(image : Image*, alpha_mask : Image) : Void
    fun bg____ImageAlphaClear_STATIC_Image_X_Color_float = ImageAlphaClear(image : Image*, color : Color, threshold : Float32) : Void
    fun bg____ImageAlphaCrop_STATIC_Image_X_float = ImageAlphaCrop(image : Image*, threshold : Float32) : Void
    fun bg____ImageAlphaPremultiply_STATIC_Image_X = ImageAlphaPremultiply(image : Image*) : Void
    fun bg____ImageCrop_STATIC_Image_X_Rectangle = ImageCrop(image : Image*, crop : Rectangle) : Void
    fun bg____ImageResize_STATIC_Image_X_int_int = ImageResize(image : Image*, new_width : Int32, new_height : Int32) : Void
    fun bg____ImageResizeNN_STATIC_Image_X_int_int = ImageResizeNN(image : Image*, new_width : Int32, new_height : Int32) : Void
    fun bg____ImageResizeCanvas_STATIC_Image_X_int_int_int_int_Color = ImageResizeCanvas(image : Image*, new_width : Int32, new_height : Int32, offset_x : Int32, offset_y : Int32, color : Color) : Void
    fun bg____ImageMipmaps_STATIC_Image_X = ImageMipmaps(image : Image*) : Void
    fun bg____ImageDither_STATIC_Image_X_int_int_int_int = ImageDither(image : Image*, r_bpp : Int32, g_bpp : Int32, b_bpp : Int32, a_bpp : Int32) : Void
    fun bg____ImageExtractPalette_STATIC_Image_int_int_X = ImageExtractPalette(image : Image, max_palette_size : Int32, extract_count : Int32*) : Color*
    fun bg____ImageText_STATIC_const_char_X_int_Color = ImageText(text : UInt8*, font_size : Int32, color : Color) : Image
    fun bg____ImageTextEx_STATIC_Font_const_char_X_float_float_Color = ImageTextEx(font : Font, text : UInt8*, font_size : Float32, spacing : Float32, tint : Color) : Image
    fun bg____ImageDraw_STATIC_Image_X_Image_Rectangle_Rectangle = ImageDraw(dst : Image*, src : Image, src_rec : Rectangle, dst_rec : Rectangle) : Void
    fun bg____ImageDrawRectangle_STATIC_Image_X_Rectangle_Color = ImageDrawRectangle(dst : Image*, rec : Rectangle, color : Color) : Void
    fun bg____ImageDrawRectangleLines_STATIC_Image_X_Rectangle_int_Color = ImageDrawRectangleLines(dst : Image*, rec : Rectangle, thick : Int32, color : Color) : Void
    fun bg____ImageDrawText_STATIC_Image_X_Vector2_const_char_X_int_Color = ImageDrawText(dst : Image*, position : Vector2, text : UInt8*, font_size : Int32, color : Color) : Void
    fun bg____ImageDrawTextEx_STATIC_Image_X_Vector2_Font_const_char_X_float_float_Color = ImageDrawTextEx(dst : Image*, position : Vector2, font : Font, text : UInt8*, font_size : Float32, spacing : Float32, color : Color) : Void
    fun bg____ImageFlipVertical_STATIC_Image_X = ImageFlipVertical(image : Image*) : Void
    fun bg____ImageFlipHorizontal_STATIC_Image_X = ImageFlipHorizontal(image : Image*) : Void
    fun bg____ImageRotateCW_STATIC_Image_X = ImageRotateCW(image : Image*) : Void
    fun bg____ImageRotateCCW_STATIC_Image_X = ImageRotateCCW(image : Image*) : Void
    fun bg____ImageColorTint_STATIC_Image_X_Color = ImageColorTint(image : Image*, color : Color) : Void
    fun bg____ImageColorInvert_STATIC_Image_X = ImageColorInvert(image : Image*) : Void
    fun bg____ImageColorGrayscale_STATIC_Image_X = ImageColorGrayscale(image : Image*) : Void
    fun bg____ImageColorContrast_STATIC_Image_X_float = ImageColorContrast(image : Image*, contrast : Float32) : Void
    fun bg____ImageColorBrightness_STATIC_Image_X_int = ImageColorBrightness(image : Image*, brightness : Int32) : Void
    fun bg____ImageColorReplace_STATIC_Image_X_Color_Color = ImageColorReplace(image : Image*, color : Color, replace : Color) : Void
    fun bg____GenImageColor_STATIC_int_int_Color = GenImageColor(width : Int32, height : Int32, color : Color) : Image
    fun bg____GenImageGradientV_STATIC_int_int_Color_Color = GenImageGradientV(width : Int32, height : Int32, top : Color, bottom : Color) : Image
    fun bg____GenImageGradientH_STATIC_int_int_Color_Color = GenImageGradientH(width : Int32, height : Int32, left : Color, right : Color) : Image
    fun bg____GenImageGradientRadial_STATIC_int_int_float_Color_Color = GenImageGradientRadial(width : Int32, height : Int32, density : Float32, inner : Color, outer : Color) : Image
    fun bg____GenImageChecked_STATIC_int_int_int_int_Color_Color = GenImageChecked(width : Int32, height : Int32, checks_x : Int32, checks_y : Int32, col1 : Color, col2 : Color) : Image
    fun bg____GenImageWhiteNoise_STATIC_int_int_float = GenImageWhiteNoise(width : Int32, height : Int32, factor : Float32) : Image
    fun bg____GenImagePerlinNoise_STATIC_int_int_int_int_float = GenImagePerlinNoise(width : Int32, height : Int32, offset_x : Int32, offset_y : Int32, scale : Float32) : Image
    fun bg____GenImageCellular_STATIC_int_int_int = GenImageCellular(width : Int32, height : Int32, tile_size : Int32) : Image
    fun bg____GenTextureMipmaps_STATIC_Texture2D_X = GenTextureMipmaps(texture : Texture2D*) : Void
    fun bg____SetTextureFilter_STATIC_Texture2D_int = SetTextureFilter(texture : Texture2D, filter_mode : Int32) : Void
    fun bg____SetTextureWrap_STATIC_Texture2D_int = SetTextureWrap(texture : Texture2D, wrap_mode : Int32) : Void
    fun bg____DrawTexture_STATIC_Texture2D_int_int_Color = DrawTexture(texture : Texture2D, pos_x : Int32, pos_y : Int32, tint : Color) : Void
    fun bg____DrawTextureV_STATIC_Texture2D_Vector2_Color = DrawTextureV(texture : Texture2D, position : Vector2, tint : Color) : Void
    fun bg____DrawTextureEx_STATIC_Texture2D_Vector2_float_float_Color = DrawTextureEx(texture : Texture2D, position : Vector2, rotation : Float32, scale : Float32, tint : Color) : Void
    fun bg____DrawTextureRec_STATIC_Texture2D_Rectangle_Vector2_Color = DrawTextureRec(texture : Texture2D, source_rec : Rectangle, position : Vector2, tint : Color) : Void
    fun bg____DrawTextureQuad_STATIC_Texture2D_Vector2_Vector2_Rectangle_Color = DrawTextureQuad(texture : Texture2D, tiling : Vector2, offset : Vector2, quad : Rectangle, tint : Color) : Void
    fun bg____DrawTexturePro_STATIC_Texture2D_Rectangle_Rectangle_Vector2_float_Color = DrawTexturePro(texture : Texture2D, source_rec : Rectangle, dest_rec : Rectangle, origin : Vector2, rotation : Float32, tint : Color) : Void
    fun bg____DrawTextureNPatch_STATIC_Texture2D_NPatchInfo_Rectangle_Vector2_float_Color = DrawTextureNPatch(texture : Texture2D, n_patch_info : NPatchInfo, dest_rec : Rectangle, origin : Vector2, rotation : Float32, tint : Color) : Void
    fun bg____GetFontDefault_STATIC_ = GetFontDefault() : Font
    fun bg____LoadFont_STATIC_const_char_X = LoadFont(file_name : UInt8*) : Font
    fun bg____LoadFontEx_STATIC_const_char_X_int_int_X_int = LoadFontEx(file_name : UInt8*, font_size : Int32, font_chars : Int32*, chars_count : Int32) : Font
    fun bg____LoadFontFromImage_STATIC_Image_Color_int = LoadFontFromImage(image : Image, key : Color, first_char : Int32) : Font
    fun bg____LoadFontData_STATIC_const_char_X_int_int_X_int_int = LoadFontData(file_name : UInt8*, font_size : Int32, font_chars : Int32*, chars_count : Int32, type : Int32) : CharInfo*
    fun bg____GenImageFontAtlas_STATIC_CharInfo_X_int_int_int_int = GenImageFontAtlas(chars : CharInfo*, chars_count : Int32, font_size : Int32, padding : Int32, pack_method : Int32) : Image
    fun bg____UnloadFont_STATIC_Font = UnloadFont(font : Font) : Void
    fun bg____DrawFPS_STATIC_int_int = DrawFPS(pos_x : Int32, pos_y : Int32) : Void
    fun bg____DrawText_STATIC_const_char_X_int_int_int_Color = DrawText(text : UInt8*, pos_x : Int32, pos_y : Int32, font_size : Int32, color : Color) : Void
    fun bg____DrawTextEx_STATIC_Font_const_char_X_Vector2_float_float_Color = DrawTextEx(font : Font, text : UInt8*, position : Vector2, font_size : Float32, spacing : Float32, tint : Color) : Void
    fun bg____DrawTextRec_STATIC_Font_const_char_X_Rectangle_float_float_bool_Color = DrawTextRec(font : Font, text : UInt8*, rec : Rectangle, font_size : Float32, spacing : Float32, word_wrap : Bool, tint : Color) : Void
    fun bg____DrawTextRecEx_STATIC_Font_const_char_X_Rectangle_float_float_bool_Color_int_int_Color_Color = DrawTextRecEx(font : Font, text : UInt8*, rec : Rectangle, font_size : Float32, spacing : Float32, word_wrap : Bool, tint : Color, select_start : Int32, select_length : Int32, select_text : Color, select_back : Color) : Void
    fun bg____MeasureText_STATIC_const_char_X_int = MeasureText(text : UInt8*, font_size : Int32) : Int32
    fun bg____MeasureTextEx_STATIC_Font_const_char_X_float_float = MeasureTextEx(font : Font, text : UInt8*, font_size : Float32, spacing : Float32) : Vector2
    fun bg____GetGlyphIndex_STATIC_Font_int = GetGlyphIndex(font : Font, character : Int32) : Int32
    fun bg____GetNextCodepoint_STATIC_const_char_X_int_X = GetNextCodepoint(text : UInt8*, count : Int32*) : Int32
    fun bg____TextIsEqual_STATIC_const_char_X_const_char_X = TextIsEqual(text1 : UInt8*, text2 : UInt8*) : Bool
    fun bg____TextLength_STATIC_const_char_X = TextLength(text : UInt8*) : Int32
    fun bg____TextCountCodepoints_STATIC_const_char_X = TextCountCodepoints(text : UInt8*) : Int32
    fun bg____TextFormat_STATIC_const_char_X_ = TextFormat(text : UInt8*, ...) : UInt8*
    fun bg____TextSubtext_STATIC_const_char_X_int_int = TextSubtext(text : UInt8*, position : Int32, length : Int32) : UInt8*
    fun bg____TextReplace_STATIC_char_X_const_char_X_const_char_X = TextReplace(text : UInt8*, replace : UInt8*, by : UInt8*) : UInt8*
    fun bg____TextInsert_STATIC_const_char_X_const_char_X_int = TextInsert(text : UInt8*, insert : UInt8*, position : Int32) : UInt8*
    fun bg____TextJoin_STATIC_const_char_XX_int_const_char_X = TextJoin(text_list : UInt8**, count : Int32, delimiter : UInt8*) : UInt8*
    fun bg____TextSplit_STATIC_const_char_X_char_int_X = TextSplit(text : UInt8*, delimiter : UInt8, count : Int32*) : UInt8**
    fun bg____TextAppend_STATIC_char_X_const_char_X_int_X = TextAppend(text : UInt8*, append : UInt8*, position : Int32*) : Void
    fun bg____TextFindIndex_STATIC_const_char_X_const_char_X = TextFindIndex(text : UInt8*, find : UInt8*) : Int32
    fun bg____TextToUpper_STATIC_const_char_X = TextToUpper(text : UInt8*) : UInt8*
    fun bg____TextToLower_STATIC_const_char_X = TextToLower(text : UInt8*) : UInt8*
    fun bg____TextToPascal_STATIC_const_char_X = TextToPascal(text : UInt8*) : UInt8*
    fun bg____TextToInteger_STATIC_const_char_X = TextToInteger(text : UInt8*) : Int32
    fun bg____DrawLine3D_STATIC_Vector3_Vector3_Color = DrawLine3D(start_pos : Vector3, end_pos : Vector3, color : Color) : Void
    fun bg____DrawCircle3D_STATIC_Vector3_float_Vector3_float_Color = DrawCircle3D(center : Vector3, radius : Float32, rotation_axis : Vector3, rotation_angle : Float32, color : Color) : Void
    fun bg____DrawCube_STATIC_Vector3_float_float_float_Color = DrawCube(position : Vector3, width : Float32, height : Float32, length : Float32, color : Color) : Void
    fun bg____DrawCubeV_STATIC_Vector3_Vector3_Color = DrawCubeV(position : Vector3, size : Vector3, color : Color) : Void
    fun bg____DrawCubeWires_STATIC_Vector3_float_float_float_Color = DrawCubeWires(position : Vector3, width : Float32, height : Float32, length : Float32, color : Color) : Void
    fun bg____DrawCubeWiresV_STATIC_Vector3_Vector3_Color = DrawCubeWiresV(position : Vector3, size : Vector3, color : Color) : Void
    fun bg____DrawCubeTexture_STATIC_Texture2D_Vector3_float_float_float_Color = DrawCubeTexture(texture : Texture2D, position : Vector3, width : Float32, height : Float32, length : Float32, color : Color) : Void
    fun bg____DrawSphere_STATIC_Vector3_float_Color = DrawSphere(center_pos : Vector3, radius : Float32, color : Color) : Void
    fun bg____DrawSphereEx_STATIC_Vector3_float_int_int_Color = DrawSphereEx(center_pos : Vector3, radius : Float32, rings : Int32, slices : Int32, color : Color) : Void
    fun bg____DrawSphereWires_STATIC_Vector3_float_int_int_Color = DrawSphereWires(center_pos : Vector3, radius : Float32, rings : Int32, slices : Int32, color : Color) : Void
    fun bg____DrawCylinder_STATIC_Vector3_float_float_float_int_Color = DrawCylinder(position : Vector3, radius_top : Float32, radius_bottom : Float32, height : Float32, slices : Int32, color : Color) : Void
    fun bg____DrawCylinderWires_STATIC_Vector3_float_float_float_int_Color = DrawCylinderWires(position : Vector3, radius_top : Float32, radius_bottom : Float32, height : Float32, slices : Int32, color : Color) : Void
    fun bg____DrawPlane_STATIC_Vector3_Vector2_Color = DrawPlane(center_pos : Vector3, size : Vector2, color : Color) : Void
    fun bg____DrawRay_STATIC_Ray_Color = DrawRay(ray : Ray, color : Color) : Void
    fun bg____DrawGrid_STATIC_int_float = DrawGrid(slices : Int32, spacing : Float32) : Void
    fun bg____DrawGizmo_STATIC_Vector3 = DrawGizmo(position : Vector3) : Void
    fun bg____LoadModel_STATIC_const_char_X = LoadModel(file_name : UInt8*) : Model
    fun bg____LoadModelFromMesh_STATIC_Mesh = LoadModelFromMesh(mesh : Mesh) : Model
    fun bg____UnloadModel_STATIC_Model = UnloadModel(model : Model) : Void
    fun bg____LoadMeshes_STATIC_const_char_X_int_X = LoadMeshes(file_name : UInt8*, mesh_count : Int32*) : Mesh*
    fun bg____ExportMesh_STATIC_Mesh_const_char_X = ExportMesh(mesh : Mesh, file_name : UInt8*) : Void
    fun bg____UnloadMesh_STATIC_Mesh_X = UnloadMesh(mesh : Mesh*) : Void
    fun bg____LoadMaterials_STATIC_const_char_X_int_X = LoadMaterials(file_name : UInt8*, material_count : Int32*) : Material*
    fun bg____LoadMaterialDefault_STATIC_ = LoadMaterialDefault() : Material
    fun bg____UnloadMaterial_STATIC_Material = UnloadMaterial(material : Material) : Void
    fun bg____SetMaterialTexture_STATIC_Material_X_int_Texture2D = SetMaterialTexture(material : Material*, map_type : Int32, texture : Texture2D) : Void
    fun bg____SetModelMeshMaterial_STATIC_Model_X_int_int = SetModelMeshMaterial(model : Model*, mesh_id : Int32, material_id : Int32) : Void
    fun bg____LoadModelAnimations_STATIC_const_char_X_int_X = LoadModelAnimations(file_name : UInt8*, anims_count : Int32*) : ModelAnimation*
    fun bg____UpdateModelAnimation_STATIC_Model_ModelAnimation_int = UpdateModelAnimation(model : Model, anim : ModelAnimation, frame : Int32) : Void
    fun bg____UnloadModelAnimation_STATIC_ModelAnimation = UnloadModelAnimation(anim : ModelAnimation) : Void
    fun bg____IsModelAnimationValid_STATIC_Model_ModelAnimation = IsModelAnimationValid(model : Model, anim : ModelAnimation) : Bool
    fun bg____GenMeshPoly_STATIC_int_float = GenMeshPoly(sides : Int32, radius : Float32) : Mesh
    fun bg____GenMeshPlane_STATIC_float_float_int_int = GenMeshPlane(width : Float32, length : Float32, res_x : Int32, res_z : Int32) : Mesh
    fun bg____GenMeshCube_STATIC_float_float_float = GenMeshCube(width : Float32, height : Float32, length : Float32) : Mesh
    fun bg____GenMeshSphere_STATIC_float_int_int = GenMeshSphere(radius : Float32, rings : Int32, slices : Int32) : Mesh
    fun bg____GenMeshHemiSphere_STATIC_float_int_int = GenMeshHemiSphere(radius : Float32, rings : Int32, slices : Int32) : Mesh
    fun bg____GenMeshCylinder_STATIC_float_float_int = GenMeshCylinder(radius : Float32, height : Float32, slices : Int32) : Mesh
    fun bg____GenMeshTorus_STATIC_float_float_int_int = GenMeshTorus(radius : Float32, size : Float32, rad_seg : Int32, sides : Int32) : Mesh
    fun bg____GenMeshKnot_STATIC_float_float_int_int = GenMeshKnot(radius : Float32, size : Float32, rad_seg : Int32, sides : Int32) : Mesh
    fun bg____GenMeshHeightmap_STATIC_Image_Vector3 = GenMeshHeightmap(heightmap : Image, size : Vector3) : Mesh
    fun bg____GenMeshCubicmap_STATIC_Image_Vector3 = GenMeshCubicmap(cubicmap : Image, cube_size : Vector3) : Mesh
    fun bg____MeshBoundingBox_STATIC_Mesh = MeshBoundingBox(mesh : Mesh) : BoundingBox
    fun bg____MeshTangents_STATIC_Mesh_X = MeshTangents(mesh : Mesh*) : Void
    fun bg____MeshBinormals_STATIC_Mesh_X = MeshBinormals(mesh : Mesh*) : Void
    fun bg____DrawModel_STATIC_Model_Vector3_float_Color = DrawModel(model : Model, position : Vector3, scale : Float32, tint : Color) : Void
    fun bg____DrawModelEx_STATIC_Model_Vector3_Vector3_float_Vector3_Color = DrawModelEx(model : Model, position : Vector3, rotation_axis : Vector3, rotation_angle : Float32, scale : Vector3, tint : Color) : Void
    fun bg____DrawModelWires_STATIC_Model_Vector3_float_Color = DrawModelWires(model : Model, position : Vector3, scale : Float32, tint : Color) : Void
    fun bg____DrawModelWiresEx_STATIC_Model_Vector3_Vector3_float_Vector3_Color = DrawModelWiresEx(model : Model, position : Vector3, rotation_axis : Vector3, rotation_angle : Float32, scale : Vector3, tint : Color) : Void
    fun bg____DrawBoundingBox_STATIC_BoundingBox_Color = DrawBoundingBox(box : BoundingBox, color : Color) : Void
    fun bg____DrawBillboard_STATIC_Camera_Texture2D_Vector3_float_Color = DrawBillboard(camera : Camera*, texture : Texture2D, center : Vector3, size : Float32, tint : Color) : Void
    fun bg____DrawBillboardRec_STATIC_Camera_Texture2D_Rectangle_Vector3_float_Color = DrawBillboardRec(camera : Camera*, texture : Texture2D, source_rec : Rectangle, center : Vector3, size : Float32, tint : Color) : Void
    fun bg____CheckCollisionSpheres_STATIC_Vector3_float_Vector3_float = CheckCollisionSpheres(center_a : Vector3, radius_a : Float32, center_b : Vector3, radius_b : Float32) : Bool
    fun bg____CheckCollisionBoxes_STATIC_BoundingBox_BoundingBox = CheckCollisionBoxes(box1 : BoundingBox, box2 : BoundingBox) : Bool
    fun bg____CheckCollisionBoxSphere_STATIC_BoundingBox_Vector3_float = CheckCollisionBoxSphere(box : BoundingBox, center_sphere : Vector3, radius_sphere : Float32) : Bool
    fun bg____CheckCollisionRaySphere_STATIC_Ray_Vector3_float = CheckCollisionRaySphere(ray : Ray, sphere_position : Vector3, sphere_radius : Float32) : Bool
    fun bg____CheckCollisionRaySphereEx_STATIC_Ray_Vector3_float_Vector3_X = CheckCollisionRaySphereEx(ray : Ray, sphere_position : Vector3, sphere_radius : Float32, collision_point : Vector3*) : Bool
    fun bg____CheckCollisionRayBox_STATIC_Ray_BoundingBox = CheckCollisionRayBox(ray : Ray, box : BoundingBox) : Bool
    fun bg____GetCollisionRayModel_STATIC_Ray_Model_X = GetCollisionRayModel(ray : Ray, model : Model*) : RayHitInfo
    fun bg____GetCollisionRayTriangle_STATIC_Ray_Vector3_Vector3_Vector3 = GetCollisionRayTriangle(ray : Ray, p1 : Vector3, p2 : Vector3, p3 : Vector3) : RayHitInfo
    fun bg____GetCollisionRayGround_STATIC_Ray_float = GetCollisionRayGround(ray : Ray, ground_height : Float32) : RayHitInfo
    fun bg____LoadText_STATIC_const_char_X = LoadText(file_name : UInt8*) : UInt8*
    fun bg____LoadShader_STATIC_const_char_X_const_char_X = LoadShader(vs_file_name : UInt8*, fs_file_name : UInt8*) : Shader
    fun bg____LoadShaderCode_STATIC_char_X_char_X = LoadShaderCode(vs_code : UInt8*, fs_code : UInt8*) : Shader
    fun bg____UnloadShader_STATIC_Shader = UnloadShader(shader : Shader) : Void
    fun bg____GetShaderDefault_STATIC_ = GetShaderDefault() : Shader
    fun bg____GetTextureDefault_STATIC_ = GetTextureDefault() : Texture2D
    fun bg____GetShaderLocation_STATIC_Shader_const_char_X = GetShaderLocation(shader : Shader, uniform_name : UInt8*) : Int32
    fun bg____SetShaderValue_STATIC_Shader_int_const_void_X_int = SetShaderValue(shader : Shader, uniform_loc : Int32, value : Void*, uniform_type : Int32) : Void
    fun bg____SetShaderValueV_STATIC_Shader_int_const_void_X_int_int = SetShaderValueV(shader : Shader, uniform_loc : Int32, value : Void*, uniform_type : Int32, count : Int32) : Void
    fun bg____SetShaderValueMatrix_STATIC_Shader_int_Matrix = SetShaderValueMatrix(shader : Shader, uniform_loc : Int32, mat : Matrix) : Void
    fun bg____SetShaderValueTexture_STATIC_Shader_int_Texture2D = SetShaderValueTexture(shader : Shader, uniform_loc : Int32, texture : Texture2D) : Void
    fun bg____SetMatrixProjection_STATIC_Matrix = SetMatrixProjection(proj : Matrix) : Void
    fun bg____SetMatrixModelview_STATIC_Matrix = SetMatrixModelview(view : Matrix) : Void
    fun bg____GetMatrixModelview_STATIC_ = GetMatrixModelview() : Matrix
    fun bg____GenTextureCubemap_STATIC_Shader_Texture2D_int = GenTextureCubemap(shader : Shader, sky_hdr : Texture2D, size : Int32) : Texture2D
    fun bg____GenTextureIrradiance_STATIC_Shader_Texture2D_int = GenTextureIrradiance(shader : Shader, cubemap : Texture2D, size : Int32) : Texture2D
    fun bg____GenTexturePrefilter_STATIC_Shader_Texture2D_int = GenTexturePrefilter(shader : Shader, cubemap : Texture2D, size : Int32) : Texture2D
    fun bg____GenTextureBRDF_STATIC_Shader_int = GenTextureBRDF(shader : Shader, size : Int32) : Texture2D
    fun bg____BeginShaderMode_STATIC_Shader = BeginShaderMode(shader : Shader) : Void
    fun bg____EndShaderMode_STATIC_ = EndShaderMode() : Void
    fun bg____BeginBlendMode_STATIC_int = BeginBlendMode(mode : Int32) : Void
    fun bg____EndBlendMode_STATIC_ = EndBlendMode() : Void
    fun bg____BeginScissorMode_STATIC_int_int_int_int = BeginScissorMode(x : Int32, y : Int32, width : Int32, height : Int32) : Void
    fun bg____EndScissorMode_STATIC_ = EndScissorMode() : Void
    fun bg____InitVrSimulator_STATIC_ = InitVrSimulator() : Void
    fun bg____CloseVrSimulator_STATIC_ = CloseVrSimulator() : Void
    fun bg____UpdateVrTracking_STATIC_Camera_X = UpdateVrTracking(camera : Camera*) : Void
    fun bg____SetVrConfiguration_STATIC_VrDeviceInfo_Shader = SetVrConfiguration(info : VrDeviceInfo, distortion : Shader) : Void
    fun bg____IsVrSimulatorReady_STATIC_ = IsVrSimulatorReady() : Bool
    fun bg____ToggleVrMode_STATIC_ = ToggleVrMode() : Void
    fun bg____BeginVrDrawing_STATIC_ = BeginVrDrawing() : Void
    fun bg____EndVrDrawing_STATIC_ = EndVrDrawing() : Void
    fun bg____InitAudioDevice_STATIC_ = InitAudioDevice() : Void
    fun bg____CloseAudioDevice_STATIC_ = CloseAudioDevice() : Void
    fun bg____IsAudioDeviceReady_STATIC_ = IsAudioDeviceReady() : Bool
    fun bg____SetMasterVolume_STATIC_float = SetMasterVolume(volume : Float32) : Void
    fun bg____LoadWave_STATIC_const_char_X = LoadWave(file_name : UInt8*) : Wave
    fun bg____LoadWaveEx_STATIC_void_X_int_int_int_int = LoadWaveEx(data : Void*, sample_count : Int32, sample_rate : Int32, sample_size : Int32, channels : Int32) : Wave
    fun bg____LoadSound_STATIC_const_char_X = LoadSound(file_name : UInt8*) : Sound
    fun bg____LoadSoundFromWave_STATIC_Wave = LoadSoundFromWave(wave : Wave) : Sound
    fun bg____UpdateSound_STATIC_Sound_const_void_X_int = UpdateSound(sound : Sound, data : Void*, samples_count : Int32) : Void
    fun bg____UnloadWave_STATIC_Wave = UnloadWave(wave : Wave) : Void
    fun bg____UnloadSound_STATIC_Sound = UnloadSound(sound : Sound) : Void
    fun bg____ExportWave_STATIC_Wave_const_char_X = ExportWave(wave : Wave, file_name : UInt8*) : Void
    fun bg____ExportWaveAsCode_STATIC_Wave_const_char_X = ExportWaveAsCode(wave : Wave, file_name : UInt8*) : Void
    fun bg____PlaySound_STATIC_Sound = PlaySound(sound : Sound) : Void
    fun bg____PauseSound_STATIC_Sound = PauseSound(sound : Sound) : Void
    fun bg____ResumeSound_STATIC_Sound = ResumeSound(sound : Sound) : Void
    fun bg____StopSound_STATIC_Sound = StopSound(sound : Sound) : Void
    fun bg____IsSoundPlaying_STATIC_Sound = IsSoundPlaying(sound : Sound) : Bool
    fun bg____SetSoundVolume_STATIC_Sound_float = SetSoundVolume(sound : Sound, volume : Float32) : Void
    fun bg____SetSoundPitch_STATIC_Sound_float = SetSoundPitch(sound : Sound, pitch : Float32) : Void
    fun bg____WaveFormat_STATIC_Wave_X_int_int_int = WaveFormat(wave : Wave*, sample_rate : Int32, sample_size : Int32, channels : Int32) : Void
    fun bg____WaveCopy_STATIC_Wave = WaveCopy(wave : Wave) : Wave
    fun bg____WaveCrop_STATIC_Wave_X_int_int = WaveCrop(wave : Wave*, init_sample : Int32, final_sample : Int32) : Void
    fun bg____GetWaveData_STATIC_Wave = GetWaveData(wave : Wave) : Float32*
    fun bg____LoadMusicStream_STATIC_const_char_X = LoadMusicStream(file_name : UInt8*) : MusicData*
    fun bg____UnloadMusicStream_STATIC_Music = UnloadMusicStream(music : MusicData*) : Void
    fun bg____PlayMusicStream_STATIC_Music = PlayMusicStream(music : MusicData*) : Void
    fun bg____UpdateMusicStream_STATIC_Music = UpdateMusicStream(music : MusicData*) : Void
    fun bg____StopMusicStream_STATIC_Music = StopMusicStream(music : MusicData*) : Void
    fun bg____PauseMusicStream_STATIC_Music = PauseMusicStream(music : MusicData*) : Void
    fun bg____ResumeMusicStream_STATIC_Music = ResumeMusicStream(music : MusicData*) : Void
    fun bg____IsMusicPlaying_STATIC_Music = IsMusicPlaying(music : MusicData*) : Bool
    fun bg____SetMusicVolume_STATIC_Music_float = SetMusicVolume(music : MusicData*, volume : Float32) : Void
    fun bg____SetMusicPitch_STATIC_Music_float = SetMusicPitch(music : MusicData*, pitch : Float32) : Void
    fun bg____SetMusicLoopCount_STATIC_Music_int = SetMusicLoopCount(music : MusicData*, count : Int32) : Void
    fun bg____GetMusicTimeLength_STATIC_Music = GetMusicTimeLength(music : MusicData*) : Float32
    fun bg____GetMusicTimePlayed_STATIC_Music = GetMusicTimePlayed(music : MusicData*) : Float32
    fun bg____InitAudioStream_STATIC_unsigned_int_unsigned_int_unsigned_int = InitAudioStream(sample_rate : Int32, sample_size : Int32, channels : Int32) : AudioStream
    fun bg____UpdateAudioStream_STATIC_AudioStream_const_void_X_int = UpdateAudioStream(stream : AudioStream, data : Void*, samples_count : Int32) : Void
    fun bg____CloseAudioStream_STATIC_AudioStream = CloseAudioStream(stream : AudioStream) : Void
    fun bg____IsAudioBufferProcessed_STATIC_AudioStream = IsAudioBufferProcessed(stream : AudioStream) : Bool
    fun bg____PlayAudioStream_STATIC_AudioStream = PlayAudioStream(stream : AudioStream) : Void
    fun bg____PauseAudioStream_STATIC_AudioStream = PauseAudioStream(stream : AudioStream) : Void
    fun bg____ResumeAudioStream_STATIC_AudioStream = ResumeAudioStream(stream : AudioStream) : Void
    fun bg____IsAudioStreamPlaying_STATIC_AudioStream = IsAudioStreamPlaying(stream : AudioStream) : Bool
    fun bg____StopAudioStream_STATIC_AudioStream = StopAudioStream(stream : AudioStream) : Void
    fun bg____SetAudioStreamVolume_STATIC_AudioStream_float = SetAudioStreamVolume(stream : AudioStream, volume : Float32) : Void
    fun bg____SetAudioStreamPitch_STATIC_AudioStream_float = SetAudioStreamPitch(stream : AudioStream, pitch : Float32) : Void
  end
  MAX_TOUCH_POINTS = 10
  MAX_SHADER_LOCATIONS = 32
  MAX_MATERIAL_MAPS = 12
  def self.init_window(width : Int32, height : Int32, title : String) : Void
    Binding.bg____InitWindow_STATIC_int_int_const_char_X(width, height, title)
  end
  
  def self.window_should_close() : Bool
    Binding.bg____WindowShouldClose_STATIC_()
  end
  
  def self.close_window() : Void
    Binding.bg____CloseWindow_STATIC_()
  end
  
  def self.is_window_ready() : Bool
    Binding.bg____IsWindowReady_STATIC_()
  end
  
  def self.is_window_minimized() : Bool
    Binding.bg____IsWindowMinimized_STATIC_()
  end
  
  def self.is_window_resized() : Bool
    Binding.bg____IsWindowResized_STATIC_()
  end
  
  def self.is_window_hidden() : Bool
    Binding.bg____IsWindowHidden_STATIC_()
  end
  
  def self.toggle_fullscreen() : Void
    Binding.bg____ToggleFullscreen_STATIC_()
  end
  
  def self.unhide_window() : Void
    Binding.bg____UnhideWindow_STATIC_()
  end
  
  def self.hide_window() : Void
    Binding.bg____HideWindow_STATIC_()
  end
  
  def self.set_window_icon(image : Image) : Void
    Binding.bg____SetWindowIcon_STATIC_Image(image)
  end
  
  def self.set_window_title(title : String) : Void
    Binding.bg____SetWindowTitle_STATIC_const_char_X(title)
  end
  
  def self.set_window_position(x : Int32, y : Int32) : Void
    Binding.bg____SetWindowPosition_STATIC_int_int(x, y)
  end
  
  def self.set_window_monitor(monitor : Int32) : Void
    Binding.bg____SetWindowMonitor_STATIC_int(monitor)
  end
  
  def self.set_window_min_size(width : Int32, height : Int32) : Void
    Binding.bg____SetWindowMinSize_STATIC_int_int(width, height)
  end
  
  def self.set_window_size(width : Int32, height : Int32) : Void
    Binding.bg____SetWindowSize_STATIC_int_int(width, height)
  end
  
  def self.get_window_handle() : Void*
    Binding.bg____GetWindowHandle_STATIC_()
  end
  
  def self.get_screen_width() : Int32
    Binding.bg____GetScreenWidth_STATIC_()
  end
  
  def self.get_screen_height() : Int32
    Binding.bg____GetScreenHeight_STATIC_()
  end
  
  def self.get_monitor_count() : Int32
    Binding.bg____GetMonitorCount_STATIC_()
  end
  
  def self.get_monitor_width(monitor : Int32) : Int32
    Binding.bg____GetMonitorWidth_STATIC_int(monitor)
  end
  
  def self.get_monitor_height(monitor : Int32) : Int32
    Binding.bg____GetMonitorHeight_STATIC_int(monitor)
  end
  
  def self.get_monitor_physical_width(monitor : Int32) : Int32
    Binding.bg____GetMonitorPhysicalWidth_STATIC_int(monitor)
  end
  
  def self.get_monitor_physical_height(monitor : Int32) : Int32
    Binding.bg____GetMonitorPhysicalHeight_STATIC_int(monitor)
  end
  
  def self.get_monitor_name(monitor : Int32) : String
    Binding.bg____GetMonitorName_STATIC_int(monitor)
  end
  
  def self.get_clipboard_text() : String
    Binding.bg____GetClipboardText_STATIC_()
  end
  
  def self.set_clipboard_text(text : String) : Void
    Binding.bg____SetClipboardText_STATIC_const_char_X(text)
  end
  
  def self.show_cursor() : Void
    Binding.bg____ShowCursor_STATIC_()
  end
  
  def self.hide_cursor() : Void
    Binding.bg____HideCursor_STATIC_()
  end
  
  def self.is_cursor_hidden() : Bool
    Binding.bg____IsCursorHidden_STATIC_()
  end
  
  def self.enable_cursor() : Void
    Binding.bg____EnableCursor_STATIC_()
  end
  
  def self.disable_cursor() : Void
    Binding.bg____DisableCursor_STATIC_()
  end
  
  def self.clear_background(color : Binding::Color) : Void
    Binding.bg____ClearBackground_STATIC_Color(color)
  end
  
  def self.begin_drawing() : Void
    Binding.bg____BeginDrawing_STATIC_()
  end
  
  def self.end_drawing() : Void
    Binding.bg____EndDrawing_STATIC_()
  end
  
  def self.begin_mode2_d(camera : Camera2D) : Void
    Binding.bg____BeginMode2D_STATIC_Camera2D(camera)
  end
  
  def self.end_mode2_d() : Void
    Binding.bg____EndMode2D_STATIC_()
  end
  
  def self.begin_mode3_d(camera : Camera3D) : Void
    Binding.bg____BeginMode3D_STATIC_Camera3D(camera)
  end
  
  def self.end_mode3_d() : Void
    Binding.bg____EndMode3D_STATIC_()
  end
  
  def self.begin_texture_mode(target : RenderTexture2D) : Void
    Binding.bg____BeginTextureMode_STATIC_RenderTexture2D(target)
  end
  
  def self.end_texture_mode() : Void
    Binding.bg____EndTextureMode_STATIC_()
  end
  
  def self.get_mouse_ray(mouse_position : Vector2, camera : Binding::Camera*) : Ray
    Ray.new(unwrap: Binding.bg____GetMouseRay_STATIC_Vector2_Camera(mouse_position, camera))
  end
  
  def self.get_world_to_screen(position : Vector3, camera : Binding::Camera*) : Vector2
    Vector2.new(unwrap: Binding.bg____GetWorldToScreen_STATIC_Vector3_Camera(position, camera))
  end
  
  def self.get_camera_matrix(camera : Binding::Camera*) : Matrix
    Matrix.new(unwrap: Binding.bg____GetCameraMatrix_STATIC_Camera(camera))
  end
  
  def self.set_target_fps(fps : Int32) : Void
    Binding.bg____SetTargetFPS_STATIC_int(fps)
  end
  
  def self.get_fps() : Int32
    Binding.bg____GetFPS_STATIC_()
  end
  
  def self.get_frame_time() : Float32
    Binding.bg____GetFrameTime_STATIC_()
  end
  
  def self.get_time() : Float64
    Binding.bg____GetTime_STATIC_()
  end
  
  def self.color_to_int(color : Binding::Color) : Int32
    Binding.bg____ColorToInt_STATIC_Color(color)
  end
  
  def self.color_normalize(color : Binding::Color) : Vector4
    Vector4.new(unwrap: Binding.bg____ColorNormalize_STATIC_Color(color))
  end
  
  def self.color_to_hsv(color : Binding::Color) : Vector3
    Vector3.new(unwrap: Binding.bg____ColorToHSV_STATIC_Color(color))
  end
  
  def self.color_from_hsv(hsv : Vector3) : Binding::Color
    Binding.bg____ColorFromHSV_STATIC_Vector3(hsv)
  end
  
  def self.get_color(hex_value : Int32) : Binding::Color
    Binding.bg____GetColor_STATIC_int(hex_value)
  end
  
  def self.fade(color : Binding::Color, alpha : Float32) : Binding::Color
    Binding.bg____Fade_STATIC_Color_float(color, alpha)
  end
  
  def self.set_config_flags(flags : UInt8) : Void
    Binding.bg____SetConfigFlags_STATIC_unsigned_char(flags)
  end
  
  def self.set_trace_log_level(log_type : Int32) : Void
    Binding.bg____SetTraceLogLevel_STATIC_int(log_type)
  end
  
  def self.set_trace_log_exit(log_type : Int32) : Void
    Binding.bg____SetTraceLogExit_STATIC_int(log_type)
  end
  
  def self.trace_log(log_type : Int32, text : String, *va_args) : Void
    Binding.bg____TraceLog_STATIC_int_const_char_X_(log_type, text, *va_args)
  end
  
  def self.take_screenshot(file_name : String) : Void
    Binding.bg____TakeScreenshot_STATIC_const_char_X(file_name)
  end
  
  def self.get_random_value(min : Int32, max : Int32) : Int32
    Binding.bg____GetRandomValue_STATIC_int_int(min, max)
  end
  
  def self.file_exists(file_name : String) : Bool
    Binding.bg____FileExists_STATIC_const_char_X(file_name)
  end
  
  def self.is_file_extension(file_name : String, ext : String) : Bool
    Binding.bg____IsFileExtension_STATIC_const_char_X_const_char_X(file_name, ext)
  end
  
  def self.get_extension(file_name : String) : String
    Binding.bg____GetExtension_STATIC_const_char_X(file_name)
  end
  
  def self.get_file_name(file_path : String) : String
    Binding.bg____GetFileName_STATIC_const_char_X(file_path)
  end
  
  def self.get_file_name_without_ext(file_path : String) : String
    Binding.bg____GetFileNameWithoutExt_STATIC_const_char_X(file_path)
  end
  
  def self.get_directory_path(file_name : String) : String
    Binding.bg____GetDirectoryPath_STATIC_const_char_X(file_name)
  end
  
  def self.get_working_directory() : String
    Binding.bg____GetWorkingDirectory_STATIC_()
  end
  
  def self.get_directory_files(dir_path : String, count : Int32*) : String*
    Binding.bg____GetDirectoryFiles_STATIC_const_char_X_int_X(dir_path, count)
  end
  
  def self.clear_directory_files() : Void
    Binding.bg____ClearDirectoryFiles_STATIC_()
  end
  
  def self.change_directory(dir : String) : Bool
    Binding.bg____ChangeDirectory_STATIC_const_char_X(dir)
  end
  
  def self.is_file_dropped() : Bool
    Binding.bg____IsFileDropped_STATIC_()
  end
  
  def self.get_dropped_files(count : Int32*) : String*
    Binding.bg____GetDroppedFiles_STATIC_int_X(count)
  end
  
  def self.clear_dropped_files() : Void
    Binding.bg____ClearDroppedFiles_STATIC_()
  end
  
  def self.get_file_mod_time(file_name : String) : LibC::Long
    Binding.bg____GetFileModTime_STATIC_const_char_X(file_name)
  end
  
  def self.storage_save_value(position : Int32, value : Int32) : Void
    Binding.bg____StorageSaveValue_STATIC_int_int(position, value)
  end
  
  def self.storage_load_value(position : Int32) : Int32
    Binding.bg____StorageLoadValue_STATIC_int(position)
  end
  
  def self.open_url(url : String) : Void
    Binding.bg____OpenURL_STATIC_const_char_X(url)
  end
  
  def self.is_key_pressed(key : Int32) : Bool
    Binding.bg____IsKeyPressed_STATIC_int(key)
  end
  
  def self.is_key_down(key : Int32) : Bool
    Binding.bg____IsKeyDown_STATIC_int(key)
  end
  
  def self.is_key_released(key : Int32) : Bool
    Binding.bg____IsKeyReleased_STATIC_int(key)
  end
  
  def self.is_key_up(key : Int32) : Bool
    Binding.bg____IsKeyUp_STATIC_int(key)
  end
  
  def self.get_key_pressed() : Int32
    Binding.bg____GetKeyPressed_STATIC_()
  end
  
  def self.set_exit_key(key : Int32) : Void
    Binding.bg____SetExitKey_STATIC_int(key)
  end
  
  def self.is_gamepad_available(gamepad : Int32) : Bool
    Binding.bg____IsGamepadAvailable_STATIC_int(gamepad)
  end
  
  def self.is_gamepad_name(gamepad : Int32, name : String) : Bool
    Binding.bg____IsGamepadName_STATIC_int_const_char_X(gamepad, name)
  end
  
  def self.get_gamepad_name(gamepad : Int32) : String
    Binding.bg____GetGamepadName_STATIC_int(gamepad)
  end
  
  def self.is_gamepad_button_pressed(gamepad : Int32, button : Int32) : Bool
    Binding.bg____IsGamepadButtonPressed_STATIC_int_int(gamepad, button)
  end
  
  def self.is_gamepad_button_down(gamepad : Int32, button : Int32) : Bool
    Binding.bg____IsGamepadButtonDown_STATIC_int_int(gamepad, button)
  end
  
  def self.is_gamepad_button_released(gamepad : Int32, button : Int32) : Bool
    Binding.bg____IsGamepadButtonReleased_STATIC_int_int(gamepad, button)
  end
  
  def self.is_gamepad_button_up(gamepad : Int32, button : Int32) : Bool
    Binding.bg____IsGamepadButtonUp_STATIC_int_int(gamepad, button)
  end
  
  def self.get_gamepad_button_pressed() : Int32
    Binding.bg____GetGamepadButtonPressed_STATIC_()
  end
  
  def self.get_gamepad_axis_count(gamepad : Int32) : Int32
    Binding.bg____GetGamepadAxisCount_STATIC_int(gamepad)
  end
  
  def self.get_gamepad_axis_movement(gamepad : Int32, axis : Int32) : Float32
    Binding.bg____GetGamepadAxisMovement_STATIC_int_int(gamepad, axis)
  end
  
  def self.is_mouse_button_pressed(button : Int32) : Bool
    Binding.bg____IsMouseButtonPressed_STATIC_int(button)
  end
  
  def self.is_mouse_button_down(button : Int32) : Bool
    Binding.bg____IsMouseButtonDown_STATIC_int(button)
  end
  
  def self.is_mouse_button_released(button : Int32) : Bool
    Binding.bg____IsMouseButtonReleased_STATIC_int(button)
  end
  
  def self.is_mouse_button_up(button : Int32) : Bool
    Binding.bg____IsMouseButtonUp_STATIC_int(button)
  end
  
  def self.get_mouse_x() : Int32
    Binding.bg____GetMouseX_STATIC_()
  end
  
  def self.get_mouse_y() : Int32
    Binding.bg____GetMouseY_STATIC_()
  end
  
  def self.get_mouse_position() : Vector2
    Vector2.new(unwrap: Binding.bg____GetMousePosition_STATIC_())
  end
  
  def self.set_mouse_position(x : Int32, y : Int32) : Void
    Binding.bg____SetMousePosition_STATIC_int_int(x, y)
  end
  
  def self.set_mouse_offset(offset_x : Int32, offset_y : Int32) : Void
    Binding.bg____SetMouseOffset_STATIC_int_int(offset_x, offset_y)
  end
  
  def self.set_mouse_scale(scale_x : Float32, scale_y : Float32) : Void
    Binding.bg____SetMouseScale_STATIC_float_float(scale_x, scale_y)
  end
  
  def self.get_mouse_wheel_move() : Int32
    Binding.bg____GetMouseWheelMove_STATIC_()
  end
  
  def self.get_touch_x() : Int32
    Binding.bg____GetTouchX_STATIC_()
  end
  
  def self.get_touch_y() : Int32
    Binding.bg____GetTouchY_STATIC_()
  end
  
  def self.get_touch_position(index : Int32) : Vector2
    Vector2.new(unwrap: Binding.bg____GetTouchPosition_STATIC_int(index))
  end
  
  def self.set_gestures_enabled(gesture_flags : Int32) : Void
    Binding.bg____SetGesturesEnabled_STATIC_unsigned_int(gesture_flags)
  end
  
  def self.is_gesture_detected(gesture : Int32) : Bool
    Binding.bg____IsGestureDetected_STATIC_int(gesture)
  end
  
  def self.get_gesture_detected() : Int32
    Binding.bg____GetGestureDetected_STATIC_()
  end
  
  def self.get_touch_points_count() : Int32
    Binding.bg____GetTouchPointsCount_STATIC_()
  end
  
  def self.get_gesture_hold_duration() : Float32
    Binding.bg____GetGestureHoldDuration_STATIC_()
  end
  
  def self.get_gesture_drag_vector() : Vector2
    Vector2.new(unwrap: Binding.bg____GetGestureDragVector_STATIC_())
  end
  
  def self.get_gesture_drag_angle() : Float32
    Binding.bg____GetGestureDragAngle_STATIC_()
  end
  
  def self.get_gesture_pinch_vector() : Vector2
    Vector2.new(unwrap: Binding.bg____GetGesturePinchVector_STATIC_())
  end
  
  def self.get_gesture_pinch_angle() : Float32
    Binding.bg____GetGesturePinchAngle_STATIC_()
  end
  
  def self.set_camera_mode(camera : Binding::Camera*, mode : Int32) : Void
    Binding.bg____SetCameraMode_STATIC_Camera_int(camera, mode)
  end
  
  def self.update_camera(camera : Binding::Camera*) : Void
    Binding.bg____UpdateCamera_STATIC_Camera_X(camera)
  end
  
  def self.set_camera_pan_control(pan_key : Int32) : Void
    Binding.bg____SetCameraPanControl_STATIC_int(pan_key)
  end
  
  def self.set_camera_alt_control(alt_key : Int32) : Void
    Binding.bg____SetCameraAltControl_STATIC_int(alt_key)
  end
  
  def self.set_camera_smooth_zoom_control(sz_key : Int32) : Void
    Binding.bg____SetCameraSmoothZoomControl_STATIC_int(sz_key)
  end
  
  def self.set_camera_move_controls(front_key : Int32, back_key : Int32, right_key : Int32, left_key : Int32, up_key : Int32, down_key : Int32) : Void
    Binding.bg____SetCameraMoveControls_STATIC_int_int_int_int_int_int(front_key, back_key, right_key, left_key, up_key, down_key)
  end
  
  def self.draw_pixel(pos_x : Int32, pos_y : Int32, color : Binding::Color) : Void
    Binding.bg____DrawPixel_STATIC_int_int_Color(pos_x, pos_y, color)
  end
  
  def self.draw_pixel_v(position : Vector2, color : Binding::Color) : Void
    Binding.bg____DrawPixelV_STATIC_Vector2_Color(position, color)
  end
  
  def self.draw_line(start_pos_x : Int32, start_pos_y : Int32, end_pos_x : Int32, end_pos_y : Int32, color : Binding::Color) : Void
    Binding.bg____DrawLine_STATIC_int_int_int_int_Color(start_pos_x, start_pos_y, end_pos_x, end_pos_y, color)
  end
  
  def self.draw_line_v(start_pos : Vector2, end_pos : Vector2, color : Binding::Color) : Void
    Binding.bg____DrawLineV_STATIC_Vector2_Vector2_Color(start_pos, end_pos, color)
  end
  
  def self.draw_line_ex(start_pos : Vector2, end_pos : Vector2, thick : Float32, color : Binding::Color) : Void
    Binding.bg____DrawLineEx_STATIC_Vector2_Vector2_float_Color(start_pos, end_pos, thick, color)
  end
  
  def self.draw_line_bezier(start_pos : Vector2, end_pos : Vector2, thick : Float32, color : Binding::Color) : Void
    Binding.bg____DrawLineBezier_STATIC_Vector2_Vector2_float_Color(start_pos, end_pos, thick, color)
  end
  
  def self.draw_line_strip(points : Vector2*, num_points : Int32, color : Binding::Color) : Void
    Binding.bg____DrawLineStrip_STATIC_Vector2_X_int_Color(points, num_points, color)
  end
  
  def self.draw_circle(center_x : Int32, center_y : Int32, radius : Float32, color : Binding::Color) : Void
    Binding.bg____DrawCircle_STATIC_int_int_float_Color(center_x, center_y, radius, color)
  end
  
  def self.draw_circle_sector(center : Vector2, radius : Float32, start_angle : Int32, end_angle : Int32, segments : Int32, color : Binding::Color) : Void
    Binding.bg____DrawCircleSector_STATIC_Vector2_float_int_int_int_Color(center, radius, start_angle, end_angle, segments, color)
  end
  
  def self.draw_circle_sector_lines(center : Vector2, radius : Float32, start_angle : Int32, end_angle : Int32, segments : Int32, color : Binding::Color) : Void
    Binding.bg____DrawCircleSectorLines_STATIC_Vector2_float_int_int_int_Color(center, radius, start_angle, end_angle, segments, color)
  end
  
  def self.draw_circle_gradient(center_x : Int32, center_y : Int32, radius : Float32, color1 : Binding::Color, color2 : Binding::Color) : Void
    Binding.bg____DrawCircleGradient_STATIC_int_int_float_Color_Color(center_x, center_y, radius, color1, color2)
  end
  
  def self.draw_circle_v(center : Vector2, radius : Float32, color : Binding::Color) : Void
    Binding.bg____DrawCircleV_STATIC_Vector2_float_Color(center, radius, color)
  end
  
  def self.draw_circle_lines(center_x : Int32, center_y : Int32, radius : Float32, color : Binding::Color) : Void
    Binding.bg____DrawCircleLines_STATIC_int_int_float_Color(center_x, center_y, radius, color)
  end
  
  def self.draw_ring(center : Vector2, inner_radius : Float32, outer_radius : Float32, start_angle : Int32, end_angle : Int32, segments : Int32, color : Binding::Color) : Void
    Binding.bg____DrawRing_STATIC_Vector2_float_float_int_int_int_Color(center, inner_radius, outer_radius, start_angle, end_angle, segments, color)
  end
  
  def self.draw_ring_lines(center : Vector2, inner_radius : Float32, outer_radius : Float32, start_angle : Int32, end_angle : Int32, segments : Int32, color : Binding::Color) : Void
    Binding.bg____DrawRingLines_STATIC_Vector2_float_float_int_int_int_Color(center, inner_radius, outer_radius, start_angle, end_angle, segments, color)
  end
  
  def self.draw_rectangle(pos_x : Int32, pos_y : Int32, width : Int32, height : Int32, color : Binding::Color) : Void
    Binding.bg____DrawRectangle_STATIC_int_int_int_int_Color(pos_x, pos_y, width, height, color)
  end
  
  def self.draw_rectangle_v(position : Vector2, size : Vector2, color : Binding::Color) : Void
    Binding.bg____DrawRectangleV_STATIC_Vector2_Vector2_Color(position, size, color)
  end
  
  def self.draw_rectangle_rec(rec : Rectangle, color : Binding::Color) : Void
    Binding.bg____DrawRectangleRec_STATIC_Rectangle_Color(rec, color)
  end
  
  def self.draw_rectangle_pro(rec : Rectangle, origin : Vector2, rotation : Float32, color : Binding::Color) : Void
    Binding.bg____DrawRectanglePro_STATIC_Rectangle_Vector2_float_Color(rec, origin, rotation, color)
  end
  
  def self.draw_rectangle_gradient_v(pos_x : Int32, pos_y : Int32, width : Int32, height : Int32, color1 : Binding::Color, color2 : Binding::Color) : Void
    Binding.bg____DrawRectangleGradientV_STATIC_int_int_int_int_Color_Color(pos_x, pos_y, width, height, color1, color2)
  end
  
  def self.draw_rectangle_gradient_h(pos_x : Int32, pos_y : Int32, width : Int32, height : Int32, color1 : Binding::Color, color2 : Binding::Color) : Void
    Binding.bg____DrawRectangleGradientH_STATIC_int_int_int_int_Color_Color(pos_x, pos_y, width, height, color1, color2)
  end
  
  def self.draw_rectangle_gradient_ex(rec : Rectangle, col1 : Binding::Color, col2 : Binding::Color, col3 : Binding::Color, col4 : Binding::Color) : Void
    Binding.bg____DrawRectangleGradientEx_STATIC_Rectangle_Color_Color_Color_Color(rec, col1, col2, col3, col4)
  end
  
  def self.draw_rectangle_lines(pos_x : Int32, pos_y : Int32, width : Int32, height : Int32, color : Binding::Color) : Void
    Binding.bg____DrawRectangleLines_STATIC_int_int_int_int_Color(pos_x, pos_y, width, height, color)
  end
  
  def self.draw_rectangle_lines_ex(rec : Rectangle, line_thick : Int32, color : Binding::Color) : Void
    Binding.bg____DrawRectangleLinesEx_STATIC_Rectangle_int_Color(rec, line_thick, color)
  end
  
  def self.draw_rectangle_rounded(rec : Rectangle, roundness : Float32, segments : Int32, color : Binding::Color) : Void
    Binding.bg____DrawRectangleRounded_STATIC_Rectangle_float_int_Color(rec, roundness, segments, color)
  end
  
  def self.draw_rectangle_rounded_lines(rec : Rectangle, roundness : Float32, segments : Int32, line_thick : Int32, color : Binding::Color) : Void
    Binding.bg____DrawRectangleRoundedLines_STATIC_Rectangle_float_int_int_Color(rec, roundness, segments, line_thick, color)
  end
  
  def self.draw_triangle(v1 : Vector2, v2 : Vector2, v3 : Vector2, color : Binding::Color) : Void
    Binding.bg____DrawTriangle_STATIC_Vector2_Vector2_Vector2_Color(v1, v2, v3, color)
  end
  
  def self.draw_triangle_lines(v1 : Vector2, v2 : Vector2, v3 : Vector2, color : Binding::Color) : Void
    Binding.bg____DrawTriangleLines_STATIC_Vector2_Vector2_Vector2_Color(v1, v2, v3, color)
  end
  
  def self.draw_triangle_fan(points : Vector2*, num_points : Int32, color : Binding::Color) : Void
    Binding.bg____DrawTriangleFan_STATIC_Vector2_X_int_Color(points, num_points, color)
  end
  
  def self.draw_poly(center : Vector2, sides : Int32, radius : Float32, rotation : Float32, color : Binding::Color) : Void
    Binding.bg____DrawPoly_STATIC_Vector2_int_float_float_Color(center, sides, radius, rotation, color)
  end
  
  def self.set_shapes_texture(texture : Texture2D, source : Rectangle) : Void
    Binding.bg____SetShapesTexture_STATIC_Texture2D_Rectangle(texture, source)
  end
  
  def self.check_collision_recs(rec1 : Rectangle, rec2 : Rectangle) : Bool
    Binding.bg____CheckCollisionRecs_STATIC_Rectangle_Rectangle(rec1, rec2)
  end
  
  def self.check_collision_circles(center1 : Vector2, radius1 : Float32, center2 : Vector2, radius2 : Float32) : Bool
    Binding.bg____CheckCollisionCircles_STATIC_Vector2_float_Vector2_float(center1, radius1, center2, radius2)
  end
  
  def self.check_collision_circle_rec(center : Vector2, radius : Float32, rec : Rectangle) : Bool
    Binding.bg____CheckCollisionCircleRec_STATIC_Vector2_float_Rectangle(center, radius, rec)
  end
  
  def self.get_collision_rec(rec1 : Rectangle, rec2 : Rectangle) : Rectangle
    Rectangle.new(unwrap: Binding.bg____GetCollisionRec_STATIC_Rectangle_Rectangle(rec1, rec2))
  end
  
  def self.check_collision_point_rec(point : Vector2, rec : Rectangle) : Bool
    Binding.bg____CheckCollisionPointRec_STATIC_Vector2_Rectangle(point, rec)
  end
  
  def self.check_collision_point_circle(point : Vector2, center : Vector2, radius : Float32) : Bool
    Binding.bg____CheckCollisionPointCircle_STATIC_Vector2_Vector2_float(point, center, radius)
  end
  
  def self.check_collision_point_triangle(point : Vector2, p1 : Vector2, p2 : Vector2, p3 : Vector2) : Bool
    Binding.bg____CheckCollisionPointTriangle_STATIC_Vector2_Vector2_Vector2_Vector2(point, p1, p2, p3)
  end
  
  def self.load_image(file_name : String) : Image
    Image.new(unwrap: Binding.bg____LoadImage_STATIC_const_char_X(file_name))
  end
  
  def self.load_image_ex(pixels : Binding::Color*, width : Int32, height : Int32) : Image
    Image.new(unwrap: Binding.bg____LoadImageEx_STATIC_Color_X_int_int(pixels, width, height))
  end
  
  def self.load_image_pro(data : Void*, width : Int32, height : Int32, format : Int32) : Image
    Image.new(unwrap: Binding.bg____LoadImagePro_STATIC_void_X_int_int_int(data, width, height, format))
  end
  
  def self.load_image_raw(file_name : String, width : Int32, height : Int32, format : Int32, header_size : Int32) : Image
    Image.new(unwrap: Binding.bg____LoadImageRaw_STATIC_const_char_X_int_int_int_int(file_name, width, height, format, header_size))
  end
  
  def self.export_image(image : Image, file_name : String) : Void
    Binding.bg____ExportImage_STATIC_Image_const_char_X(image, file_name)
  end
  
  def self.export_image_as_code(image : Image, file_name : String) : Void
    Binding.bg____ExportImageAsCode_STATIC_Image_const_char_X(image, file_name)
  end
  
  def self.load_texture(file_name : String) : Texture2D
    Texture2D.new(unwrap: Binding.bg____LoadTexture_STATIC_const_char_X(file_name))
  end
  
  def self.load_texture_from_image(image : Image) : Texture2D
    Texture2D.new(unwrap: Binding.bg____LoadTextureFromImage_STATIC_Image(image))
  end
  
  def self.load_texture_cubemap(image : Image, layout_type : Int32) : Binding::TextureCubemap*
    Binding.bg____LoadTextureCubemap_STATIC_Image_int(image, layout_type)
  end
  
  def self.load_render_texture(width : Int32, height : Int32) : RenderTexture2D
    RenderTexture2D.new(unwrap: Binding.bg____LoadRenderTexture_STATIC_int_int(width, height))
  end
  
  def self.unload_image(image : Image) : Void
    Binding.bg____UnloadImage_STATIC_Image(image)
  end
  
  def self.unload_texture(texture : Texture2D) : Void
    Binding.bg____UnloadTexture_STATIC_Texture2D(texture)
  end
  
  def self.unload_render_texture(target : RenderTexture2D) : Void
    Binding.bg____UnloadRenderTexture_STATIC_RenderTexture2D(target)
  end
  
  def self.get_image_data(image : Image) : Binding::Color*
    Binding.bg____GetImageData_STATIC_Image(image)
  end
  
  def self.get_image_data_normalized(image : Image) : Vector4*
    Vector4.new(unwrap: Binding.bg____GetImageDataNormalized_STATIC_Image(image))
  end
  
  def self.get_pixel_data_size(width : Int32, height : Int32, format : Int32) : Int32
    Binding.bg____GetPixelDataSize_STATIC_int_int_int(width, height, format)
  end
  
  def self.get_texture_data(texture : Texture2D) : Image
    Image.new(unwrap: Binding.bg____GetTextureData_STATIC_Texture2D(texture))
  end
  
  def self.get_screen_data() : Image
    Image.new(unwrap: Binding.bg____GetScreenData_STATIC_())
  end
  
  def self.update_texture(texture : Texture2D, pixels : Void*) : Void
    Binding.bg____UpdateTexture_STATIC_Texture2D_const_void_X(texture, pixels)
  end
  
  def self.image_copy(image : Image) : Image
    Image.new(unwrap: Binding.bg____ImageCopy_STATIC_Image(image))
  end
  
  def self.image_to_pot(image : Image*, fill_color : Binding::Color) : Void
    Binding.bg____ImageToPOT_STATIC_Image_X_Color(image, fill_color)
  end
  
  def self.image_format(image : Image*, new_format : Int32) : Void
    Binding.bg____ImageFormat_STATIC_Image_X_int(image, new_format)
  end
  
  def self.image_alpha_mask(image : Image*, alpha_mask : Image) : Void
    Binding.bg____ImageAlphaMask_STATIC_Image_X_Image(image, alpha_mask)
  end
  
  def self.image_alpha_clear(image : Image*, color : Binding::Color, threshold : Float32) : Void
    Binding.bg____ImageAlphaClear_STATIC_Image_X_Color_float(image, color, threshold)
  end
  
  def self.image_alpha_crop(image : Image*, threshold : Float32) : Void
    Binding.bg____ImageAlphaCrop_STATIC_Image_X_float(image, threshold)
  end
  
  def self.image_alpha_premultiply(image : Image*) : Void
    Binding.bg____ImageAlphaPremultiply_STATIC_Image_X(image)
  end
  
  def self.image_crop(image : Image*, crop : Rectangle) : Void
    Binding.bg____ImageCrop_STATIC_Image_X_Rectangle(image, crop)
  end
  
  def self.image_resize(image : Image*, new_width : Int32, new_height : Int32) : Void
    Binding.bg____ImageResize_STATIC_Image_X_int_int(image, new_width, new_height)
  end
  
  def self.image_resize_nn(image : Image*, new_width : Int32, new_height : Int32) : Void
    Binding.bg____ImageResizeNN_STATIC_Image_X_int_int(image, new_width, new_height)
  end
  
  def self.image_resize_canvas(image : Image*, new_width : Int32, new_height : Int32, offset_x : Int32, offset_y : Int32, color : Binding::Color) : Void
    Binding.bg____ImageResizeCanvas_STATIC_Image_X_int_int_int_int_Color(image, new_width, new_height, offset_x, offset_y, color)
  end
  
  def self.image_mipmaps(image : Image*) : Void
    Binding.bg____ImageMipmaps_STATIC_Image_X(image)
  end
  
  def self.image_dither(image : Image*, r_bpp : Int32, g_bpp : Int32, b_bpp : Int32, a_bpp : Int32) : Void
    Binding.bg____ImageDither_STATIC_Image_X_int_int_int_int(image, r_bpp, g_bpp, b_bpp, a_bpp)
  end
  
  def self.image_extract_palette(image : Image, max_palette_size : Int32, extract_count : Int32*) : Binding::Color*
    Binding.bg____ImageExtractPalette_STATIC_Image_int_int_X(image, max_palette_size, extract_count)
  end
  
  def self.image_text(text : String, font_size : Int32, color : Binding::Color) : Image
    Image.new(unwrap: Binding.bg____ImageText_STATIC_const_char_X_int_Color(text, font_size, color))
  end
  
  def self.image_text_ex(font : Font, text : String, font_size : Float32, spacing : Float32, tint : Binding::Color) : Image
    Image.new(unwrap: Binding.bg____ImageTextEx_STATIC_Font_const_char_X_float_float_Color(font, text, font_size, spacing, tint))
  end
  
  def self.image_draw(dst : Image*, src : Image, src_rec : Rectangle, dst_rec : Rectangle) : Void
    Binding.bg____ImageDraw_STATIC_Image_X_Image_Rectangle_Rectangle(dst, src, src_rec, dst_rec)
  end
  
  def self.image_draw_rectangle(dst : Image*, rec : Rectangle, color : Binding::Color) : Void
    Binding.bg____ImageDrawRectangle_STATIC_Image_X_Rectangle_Color(dst, rec, color)
  end
  
  def self.image_draw_rectangle_lines(dst : Image*, rec : Rectangle, thick : Int32, color : Binding::Color) : Void
    Binding.bg____ImageDrawRectangleLines_STATIC_Image_X_Rectangle_int_Color(dst, rec, thick, color)
  end
  
  def self.image_draw_text(dst : Image*, position : Vector2, text : String, font_size : Int32, color : Binding::Color) : Void
    Binding.bg____ImageDrawText_STATIC_Image_X_Vector2_const_char_X_int_Color(dst, position, text, font_size, color)
  end
  
  def self.image_draw_text_ex(dst : Image*, position : Vector2, font : Font, text : String, font_size : Float32, spacing : Float32, color : Binding::Color) : Void
    Binding.bg____ImageDrawTextEx_STATIC_Image_X_Vector2_Font_const_char_X_float_float_Color(dst, position, font, text, font_size, spacing, color)
  end
  
  def self.image_flip_vertical(image : Image*) : Void
    Binding.bg____ImageFlipVertical_STATIC_Image_X(image)
  end
  
  def self.image_flip_horizontal(image : Image*) : Void
    Binding.bg____ImageFlipHorizontal_STATIC_Image_X(image)
  end
  
  def self.image_rotate_cw(image : Image*) : Void
    Binding.bg____ImageRotateCW_STATIC_Image_X(image)
  end
  
  def self.image_rotate_ccw(image : Image*) : Void
    Binding.bg____ImageRotateCCW_STATIC_Image_X(image)
  end
  
  def self.image_color_tint(image : Image*, color : Binding::Color) : Void
    Binding.bg____ImageColorTint_STATIC_Image_X_Color(image, color)
  end
  
  def self.image_color_invert(image : Image*) : Void
    Binding.bg____ImageColorInvert_STATIC_Image_X(image)
  end
  
  def self.image_color_grayscale(image : Image*) : Void
    Binding.bg____ImageColorGrayscale_STATIC_Image_X(image)
  end
  
  def self.image_color_contrast(image : Image*, contrast : Float32) : Void
    Binding.bg____ImageColorContrast_STATIC_Image_X_float(image, contrast)
  end
  
  def self.image_color_brightness(image : Image*, brightness : Int32) : Void
    Binding.bg____ImageColorBrightness_STATIC_Image_X_int(image, brightness)
  end
  
  def self.image_color_replace(image : Image*, color : Binding::Color, replace : Binding::Color) : Void
    Binding.bg____ImageColorReplace_STATIC_Image_X_Color_Color(image, color, replace)
  end
  
  def self.gen_image_color(width : Int32, height : Int32, color : Binding::Color) : Image
    Image.new(unwrap: Binding.bg____GenImageColor_STATIC_int_int_Color(width, height, color))
  end
  
  def self.gen_image_gradient_v(width : Int32, height : Int32, top : Binding::Color, bottom : Binding::Color) : Image
    Image.new(unwrap: Binding.bg____GenImageGradientV_STATIC_int_int_Color_Color(width, height, top, bottom))
  end
  
  def self.gen_image_gradient_h(width : Int32, height : Int32, left : Binding::Color, right : Binding::Color) : Image
    Image.new(unwrap: Binding.bg____GenImageGradientH_STATIC_int_int_Color_Color(width, height, left, right))
  end
  
  def self.gen_image_gradient_radial(width : Int32, height : Int32, density : Float32, inner : Binding::Color, outer : Binding::Color) : Image
    Image.new(unwrap: Binding.bg____GenImageGradientRadial_STATIC_int_int_float_Color_Color(width, height, density, inner, outer))
  end
  
  def self.gen_image_checked(width : Int32, height : Int32, checks_x : Int32, checks_y : Int32, col1 : Binding::Color, col2 : Binding::Color) : Image
    Image.new(unwrap: Binding.bg____GenImageChecked_STATIC_int_int_int_int_Color_Color(width, height, checks_x, checks_y, col1, col2))
  end
  
  def self.gen_image_white_noise(width : Int32, height : Int32, factor : Float32) : Image
    Image.new(unwrap: Binding.bg____GenImageWhiteNoise_STATIC_int_int_float(width, height, factor))
  end
  
  def self.gen_image_perlin_noise(width : Int32, height : Int32, offset_x : Int32, offset_y : Int32, scale : Float32) : Image
    Image.new(unwrap: Binding.bg____GenImagePerlinNoise_STATIC_int_int_int_int_float(width, height, offset_x, offset_y, scale))
  end
  
  def self.gen_image_cellular(width : Int32, height : Int32, tile_size : Int32) : Image
    Image.new(unwrap: Binding.bg____GenImageCellular_STATIC_int_int_int(width, height, tile_size))
  end
  
  def self.gen_texture_mipmaps(texture : Texture2D*) : Void
    Binding.bg____GenTextureMipmaps_STATIC_Texture2D_X(texture)
  end
  
  def self.set_texture_filter(texture : Texture2D, filter_mode : Int32) : Void
    Binding.bg____SetTextureFilter_STATIC_Texture2D_int(texture, filter_mode)
  end
  
  def self.set_texture_wrap(texture : Texture2D, wrap_mode : Int32) : Void
    Binding.bg____SetTextureWrap_STATIC_Texture2D_int(texture, wrap_mode)
  end
  
  def self.draw_texture(texture : Texture2D, pos_x : Int32, pos_y : Int32, tint : Binding::Color) : Void
    Binding.bg____DrawTexture_STATIC_Texture2D_int_int_Color(texture, pos_x, pos_y, tint)
  end
  
  def self.draw_texture_v(texture : Texture2D, position : Vector2, tint : Binding::Color) : Void
    Binding.bg____DrawTextureV_STATIC_Texture2D_Vector2_Color(texture, position, tint)
  end
  
  def self.draw_texture_ex(texture : Texture2D, position : Vector2, rotation : Float32, scale : Float32, tint : Binding::Color) : Void
    Binding.bg____DrawTextureEx_STATIC_Texture2D_Vector2_float_float_Color(texture, position, rotation, scale, tint)
  end
  
  def self.draw_texture_rec(texture : Texture2D, source_rec : Rectangle, position : Vector2, tint : Binding::Color) : Void
    Binding.bg____DrawTextureRec_STATIC_Texture2D_Rectangle_Vector2_Color(texture, source_rec, position, tint)
  end
  
  def self.draw_texture_quad(texture : Texture2D, tiling : Vector2, offset : Vector2, quad : Rectangle, tint : Binding::Color) : Void
    Binding.bg____DrawTextureQuad_STATIC_Texture2D_Vector2_Vector2_Rectangle_Color(texture, tiling, offset, quad, tint)
  end
  
  def self.draw_texture_pro(texture : Texture2D, source_rec : Rectangle, dest_rec : Rectangle, origin : Vector2, rotation : Float32, tint : Binding::Color) : Void
    Binding.bg____DrawTexturePro_STATIC_Texture2D_Rectangle_Rectangle_Vector2_float_Color(texture, source_rec, dest_rec, origin, rotation, tint)
  end
  
  def self.draw_texture_n_patch(texture : Texture2D, n_patch_info : NPatchInfo, dest_rec : Rectangle, origin : Vector2, rotation : Float32, tint : Binding::Color) : Void
    Binding.bg____DrawTextureNPatch_STATIC_Texture2D_NPatchInfo_Rectangle_Vector2_float_Color(texture, n_patch_info, dest_rec, origin, rotation, tint)
  end
  
  def self.get_font_default() : Font
    Font.new(unwrap: Binding.bg____GetFontDefault_STATIC_())
  end
  
  def self.load_font(file_name : String) : Font
    Font.new(unwrap: Binding.bg____LoadFont_STATIC_const_char_X(file_name))
  end
  
  def self.load_font_ex(file_name : String, font_size : Int32, font_chars : Int32*, chars_count : Int32) : Font
    Font.new(unwrap: Binding.bg____LoadFontEx_STATIC_const_char_X_int_int_X_int(file_name, font_size, font_chars, chars_count))
  end
  
  def self.load_font_from_image(image : Image, key : Binding::Color, first_char : Int32) : Font
    Font.new(unwrap: Binding.bg____LoadFontFromImage_STATIC_Image_Color_int(image, key, first_char))
  end
  
  def self.load_font_data(file_name : String, font_size : Int32, font_chars : Int32*, chars_count : Int32, type : Int32) : CharInfo*
    CharInfo.new(unwrap: Binding.bg____LoadFontData_STATIC_const_char_X_int_int_X_int_int(file_name, font_size, font_chars, chars_count, type))
  end
  
  def self.gen_image_font_atlas(chars : CharInfo*, chars_count : Int32, font_size : Int32, padding : Int32, pack_method : Int32) : Image
    Image.new(unwrap: Binding.bg____GenImageFontAtlas_STATIC_CharInfo_X_int_int_int_int(chars, chars_count, font_size, padding, pack_method))
  end
  
  def self.unload_font(font : Font) : Void
    Binding.bg____UnloadFont_STATIC_Font(font)
  end
  
  def self.draw_fps(pos_x : Int32, pos_y : Int32) : Void
    Binding.bg____DrawFPS_STATIC_int_int(pos_x, pos_y)
  end
  
  def self.draw_text(text : String, pos_x : Int32, pos_y : Int32, font_size : Int32, color : Binding::Color) : Void
    Binding.bg____DrawText_STATIC_const_char_X_int_int_int_Color(text, pos_x, pos_y, font_size, color)
  end
  
  def self.draw_text_ex(font : Font, text : String, position : Vector2, font_size : Float32, spacing : Float32, tint : Binding::Color) : Void
    Binding.bg____DrawTextEx_STATIC_Font_const_char_X_Vector2_float_float_Color(font, text, position, font_size, spacing, tint)
  end
  
  def self.draw_text_rec(font : Font, text : String, rec : Rectangle, font_size : Float32, spacing : Float32, word_wrap : Bool, tint : Binding::Color) : Void
    Binding.bg____DrawTextRec_STATIC_Font_const_char_X_Rectangle_float_float_bool_Color(font, text, rec, font_size, spacing, word_wrap, tint)
  end
  
  def self.draw_text_rec_ex(font : Font, text : String, rec : Rectangle, font_size : Float32, spacing : Float32, word_wrap : Bool, tint : Binding::Color, select_start : Int32, select_length : Int32, select_text : Binding::Color, select_back : Binding::Color) : Void
    Binding.bg____DrawTextRecEx_STATIC_Font_const_char_X_Rectangle_float_float_bool_Color_int_int_Color_Color(font, text, rec, font_size, spacing, word_wrap, tint, select_start, select_length, select_text, select_back)
  end
  
  def self.measure_text(text : String, font_size : Int32) : Int32
    Binding.bg____MeasureText_STATIC_const_char_X_int(text, font_size)
  end
  
  def self.measure_text_ex(font : Font, text : String, font_size : Float32, spacing : Float32) : Vector2
    Vector2.new(unwrap: Binding.bg____MeasureTextEx_STATIC_Font_const_char_X_float_float(font, text, font_size, spacing))
  end
  
  def self.get_glyph_index(font : Font, character : Int32) : Int32
    Binding.bg____GetGlyphIndex_STATIC_Font_int(font, character)
  end
  
  def self.get_next_codepoint(text : String, count : Int32*) : Int32
    Binding.bg____GetNextCodepoint_STATIC_const_char_X_int_X(text, count)
  end
  
  def self.text_is_equal(text1 : String, text2 : String) : Bool
    Binding.bg____TextIsEqual_STATIC_const_char_X_const_char_X(text1, text2)
  end
  
  def self.text_length(text : String) : Int32
    Binding.bg____TextLength_STATIC_const_char_X(text)
  end
  
  def self.text_count_codepoints(text : String) : Int32
    Binding.bg____TextCountCodepoints_STATIC_const_char_X(text)
  end
  
  def self.text_format(text : String, *va_args) : String
    Binding.bg____TextFormat_STATIC_const_char_X_(text, *va_args)
  end
  
  def self.text_subtext(text : String, position : Int32, length : Int32) : String
    Binding.bg____TextSubtext_STATIC_const_char_X_int_int(text, position, length)
  end
  
  def self.text_replace(text : String, replace : String, by : String) : String
    Binding.bg____TextReplace_STATIC_char_X_const_char_X_const_char_X(text, replace, by)
  end
  
  def self.text_insert(text : String, insert : String, position : Int32) : String
    Binding.bg____TextInsert_STATIC_const_char_X_const_char_X_int(text, insert, position)
  end
  
  def self.text_join(text_list : String*, count : Int32, delimiter : String) : String
    Binding.bg____TextJoin_STATIC_const_char_XX_int_const_char_X(text_list, count, delimiter)
  end
  
  def self.text_split(text : String, delimiter : UInt8, count : Int32*) : String*
    Binding.bg____TextSplit_STATIC_const_char_X_char_int_X(text, delimiter, count)
  end
  
  def self.text_append(text : String, append : String, position : Int32*) : Void
    Binding.bg____TextAppend_STATIC_char_X_const_char_X_int_X(text, append, position)
  end
  
  def self.text_find_index(text : String, find : String) : Int32
    Binding.bg____TextFindIndex_STATIC_const_char_X_const_char_X(text, find)
  end
  
  def self.text_to_upper(text : String) : String
    Binding.bg____TextToUpper_STATIC_const_char_X(text)
  end
  
  def self.text_to_lower(text : String) : String
    Binding.bg____TextToLower_STATIC_const_char_X(text)
  end
  
  def self.text_to_pascal(text : String) : String
    Binding.bg____TextToPascal_STATIC_const_char_X(text)
  end
  
  def self.text_to_integer(text : String) : Int32
    Binding.bg____TextToInteger_STATIC_const_char_X(text)
  end
  
  def self.draw_line3_d(start_pos : Vector3, end_pos : Vector3, color : Binding::Color) : Void
    Binding.bg____DrawLine3D_STATIC_Vector3_Vector3_Color(start_pos, end_pos, color)
  end
  
  def self.draw_circle3_d(center : Vector3, radius : Float32, rotation_axis : Vector3, rotation_angle : Float32, color : Binding::Color) : Void
    Binding.bg____DrawCircle3D_STATIC_Vector3_float_Vector3_float_Color(center, radius, rotation_axis, rotation_angle, color)
  end
  
  def self.draw_cube(position : Vector3, width : Float32, height : Float32, length : Float32, color : Binding::Color) : Void
    Binding.bg____DrawCube_STATIC_Vector3_float_float_float_Color(position, width, height, length, color)
  end
  
  def self.draw_cube_v(position : Vector3, size : Vector3, color : Binding::Color) : Void
    Binding.bg____DrawCubeV_STATIC_Vector3_Vector3_Color(position, size, color)
  end
  
  def self.draw_cube_wires(position : Vector3, width : Float32, height : Float32, length : Float32, color : Binding::Color) : Void
    Binding.bg____DrawCubeWires_STATIC_Vector3_float_float_float_Color(position, width, height, length, color)
  end
  
  def self.draw_cube_wires_v(position : Vector3, size : Vector3, color : Binding::Color) : Void
    Binding.bg____DrawCubeWiresV_STATIC_Vector3_Vector3_Color(position, size, color)
  end
  
  def self.draw_cube_texture(texture : Texture2D, position : Vector3, width : Float32, height : Float32, length : Float32, color : Binding::Color) : Void
    Binding.bg____DrawCubeTexture_STATIC_Texture2D_Vector3_float_float_float_Color(texture, position, width, height, length, color)
  end
  
  def self.draw_sphere(center_pos : Vector3, radius : Float32, color : Binding::Color) : Void
    Binding.bg____DrawSphere_STATIC_Vector3_float_Color(center_pos, radius, color)
  end
  
  def self.draw_sphere_ex(center_pos : Vector3, radius : Float32, rings : Int32, slices : Int32, color : Binding::Color) : Void
    Binding.bg____DrawSphereEx_STATIC_Vector3_float_int_int_Color(center_pos, radius, rings, slices, color)
  end
  
  def self.draw_sphere_wires(center_pos : Vector3, radius : Float32, rings : Int32, slices : Int32, color : Binding::Color) : Void
    Binding.bg____DrawSphereWires_STATIC_Vector3_float_int_int_Color(center_pos, radius, rings, slices, color)
  end
  
  def self.draw_cylinder(position : Vector3, radius_top : Float32, radius_bottom : Float32, height : Float32, slices : Int32, color : Binding::Color) : Void
    Binding.bg____DrawCylinder_STATIC_Vector3_float_float_float_int_Color(position, radius_top, radius_bottom, height, slices, color)
  end
  
  def self.draw_cylinder_wires(position : Vector3, radius_top : Float32, radius_bottom : Float32, height : Float32, slices : Int32, color : Binding::Color) : Void
    Binding.bg____DrawCylinderWires_STATIC_Vector3_float_float_float_int_Color(position, radius_top, radius_bottom, height, slices, color)
  end
  
  def self.draw_plane(center_pos : Vector3, size : Vector2, color : Binding::Color) : Void
    Binding.bg____DrawPlane_STATIC_Vector3_Vector2_Color(center_pos, size, color)
  end
  
  def self.draw_ray(ray : Ray, color : Binding::Color) : Void
    Binding.bg____DrawRay_STATIC_Ray_Color(ray, color)
  end
  
  def self.draw_grid(slices : Int32, spacing : Float32) : Void
    Binding.bg____DrawGrid_STATIC_int_float(slices, spacing)
  end
  
  def self.draw_gizmo(position : Vector3) : Void
    Binding.bg____DrawGizmo_STATIC_Vector3(position)
  end
  
  def self.load_model(file_name : String) : Model
    Model.new(unwrap: Binding.bg____LoadModel_STATIC_const_char_X(file_name))
  end
  
  def self.load_model_from_mesh(mesh : Mesh) : Model
    Model.new(unwrap: Binding.bg____LoadModelFromMesh_STATIC_Mesh(mesh))
  end
  
  def self.unload_model(model : Model) : Void
    Binding.bg____UnloadModel_STATIC_Model(model)
  end
  
  def self.load_meshes(file_name : String, mesh_count : Int32*) : Mesh*
    Mesh.new(unwrap: Binding.bg____LoadMeshes_STATIC_const_char_X_int_X(file_name, mesh_count))
  end
  
  def self.export_mesh(mesh : Mesh, file_name : String) : Void
    Binding.bg____ExportMesh_STATIC_Mesh_const_char_X(mesh, file_name)
  end
  
  def self.unload_mesh(mesh : Mesh*) : Void
    Binding.bg____UnloadMesh_STATIC_Mesh_X(mesh)
  end
  
  def self.load_materials(file_name : String, material_count : Int32*) : Material*
    Material.new(unwrap: Binding.bg____LoadMaterials_STATIC_const_char_X_int_X(file_name, material_count))
  end
  
  def self.load_material_default() : Material
    Material.new(unwrap: Binding.bg____LoadMaterialDefault_STATIC_())
  end
  
  def self.unload_material(material : Material) : Void
    Binding.bg____UnloadMaterial_STATIC_Material(material)
  end
  
  def self.set_material_texture(material : Material*, map_type : Int32, texture : Texture2D) : Void
    Binding.bg____SetMaterialTexture_STATIC_Material_X_int_Texture2D(material, map_type, texture)
  end
  
  def self.set_model_mesh_material(model : Model*, mesh_id : Int32, material_id : Int32) : Void
    Binding.bg____SetModelMeshMaterial_STATIC_Model_X_int_int(model, mesh_id, material_id)
  end
  
  def self.load_model_animations(file_name : String, anims_count : Int32*) : ModelAnimation*
    ModelAnimation.new(unwrap: Binding.bg____LoadModelAnimations_STATIC_const_char_X_int_X(file_name, anims_count))
  end
  
  def self.update_model_animation(model : Model, anim : ModelAnimation, frame : Int32) : Void
    Binding.bg____UpdateModelAnimation_STATIC_Model_ModelAnimation_int(model, anim, frame)
  end
  
  def self.unload_model_animation(anim : ModelAnimation) : Void
    Binding.bg____UnloadModelAnimation_STATIC_ModelAnimation(anim)
  end
  
  def self.is_model_animation_valid(model : Model, anim : ModelAnimation) : Bool
    Binding.bg____IsModelAnimationValid_STATIC_Model_ModelAnimation(model, anim)
  end
  
  def self.gen_mesh_poly(sides : Int32, radius : Float32) : Mesh
    Mesh.new(unwrap: Binding.bg____GenMeshPoly_STATIC_int_float(sides, radius))
  end
  
  def self.gen_mesh_plane(width : Float32, length : Float32, res_x : Int32, res_z : Int32) : Mesh
    Mesh.new(unwrap: Binding.bg____GenMeshPlane_STATIC_float_float_int_int(width, length, res_x, res_z))
  end
  
  def self.gen_mesh_cube(width : Float32, height : Float32, length : Float32) : Mesh
    Mesh.new(unwrap: Binding.bg____GenMeshCube_STATIC_float_float_float(width, height, length))
  end
  
  def self.gen_mesh_sphere(radius : Float32, rings : Int32, slices : Int32) : Mesh
    Mesh.new(unwrap: Binding.bg____GenMeshSphere_STATIC_float_int_int(radius, rings, slices))
  end
  
  def self.gen_mesh_hemi_sphere(radius : Float32, rings : Int32, slices : Int32) : Mesh
    Mesh.new(unwrap: Binding.bg____GenMeshHemiSphere_STATIC_float_int_int(radius, rings, slices))
  end
  
  def self.gen_mesh_cylinder(radius : Float32, height : Float32, slices : Int32) : Mesh
    Mesh.new(unwrap: Binding.bg____GenMeshCylinder_STATIC_float_float_int(radius, height, slices))
  end
  
  def self.gen_mesh_torus(radius : Float32, size : Float32, rad_seg : Int32, sides : Int32) : Mesh
    Mesh.new(unwrap: Binding.bg____GenMeshTorus_STATIC_float_float_int_int(radius, size, rad_seg, sides))
  end
  
  def self.gen_mesh_knot(radius : Float32, size : Float32, rad_seg : Int32, sides : Int32) : Mesh
    Mesh.new(unwrap: Binding.bg____GenMeshKnot_STATIC_float_float_int_int(radius, size, rad_seg, sides))
  end
  
  def self.gen_mesh_heightmap(heightmap : Image, size : Vector3) : Mesh
    Mesh.new(unwrap: Binding.bg____GenMeshHeightmap_STATIC_Image_Vector3(heightmap, size))
  end
  
  def self.gen_mesh_cubicmap(cubicmap : Image, cube_size : Vector3) : Mesh
    Mesh.new(unwrap: Binding.bg____GenMeshCubicmap_STATIC_Image_Vector3(cubicmap, cube_size))
  end
  
  def self.mesh_bounding_box(mesh : Mesh) : BoundingBox
    BoundingBox.new(unwrap: Binding.bg____MeshBoundingBox_STATIC_Mesh(mesh))
  end
  
  def self.mesh_tangents(mesh : Mesh*) : Void
    Binding.bg____MeshTangents_STATIC_Mesh_X(mesh)
  end
  
  def self.mesh_binormals(mesh : Mesh*) : Void
    Binding.bg____MeshBinormals_STATIC_Mesh_X(mesh)
  end
  
  def self.draw_model(model : Model, position : Vector3, scale : Float32, tint : Binding::Color) : Void
    Binding.bg____DrawModel_STATIC_Model_Vector3_float_Color(model, position, scale, tint)
  end
  
  def self.draw_model_ex(model : Model, position : Vector3, rotation_axis : Vector3, rotation_angle : Float32, scale : Vector3, tint : Binding::Color) : Void
    Binding.bg____DrawModelEx_STATIC_Model_Vector3_Vector3_float_Vector3_Color(model, position, rotation_axis, rotation_angle, scale, tint)
  end
  
  def self.draw_model_wires(model : Model, position : Vector3, scale : Float32, tint : Binding::Color) : Void
    Binding.bg____DrawModelWires_STATIC_Model_Vector3_float_Color(model, position, scale, tint)
  end
  
  def self.draw_model_wires_ex(model : Model, position : Vector3, rotation_axis : Vector3, rotation_angle : Float32, scale : Vector3, tint : Binding::Color) : Void
    Binding.bg____DrawModelWiresEx_STATIC_Model_Vector3_Vector3_float_Vector3_Color(model, position, rotation_axis, rotation_angle, scale, tint)
  end
  
  def self.draw_bounding_box(box : BoundingBox, color : Binding::Color) : Void
    Binding.bg____DrawBoundingBox_STATIC_BoundingBox_Color(box, color)
  end
  
  def self.draw_billboard(camera : Binding::Camera*, texture : Texture2D, center : Vector3, size : Float32, tint : Binding::Color) : Void
    Binding.bg____DrawBillboard_STATIC_Camera_Texture2D_Vector3_float_Color(camera, texture, center, size, tint)
  end
  
  def self.draw_billboard_rec(camera : Binding::Camera*, texture : Texture2D, source_rec : Rectangle, center : Vector3, size : Float32, tint : Binding::Color) : Void
    Binding.bg____DrawBillboardRec_STATIC_Camera_Texture2D_Rectangle_Vector3_float_Color(camera, texture, source_rec, center, size, tint)
  end
  
  def self.check_collision_spheres(center_a : Vector3, radius_a : Float32, center_b : Vector3, radius_b : Float32) : Bool
    Binding.bg____CheckCollisionSpheres_STATIC_Vector3_float_Vector3_float(center_a, radius_a, center_b, radius_b)
  end
  
  def self.check_collision_boxes(box1 : BoundingBox, box2 : BoundingBox) : Bool
    Binding.bg____CheckCollisionBoxes_STATIC_BoundingBox_BoundingBox(box1, box2)
  end
  
  def self.check_collision_box_sphere(box : BoundingBox, center_sphere : Vector3, radius_sphere : Float32) : Bool
    Binding.bg____CheckCollisionBoxSphere_STATIC_BoundingBox_Vector3_float(box, center_sphere, radius_sphere)
  end
  
  def self.check_collision_ray_sphere(ray : Ray, sphere_position : Vector3, sphere_radius : Float32) : Bool
    Binding.bg____CheckCollisionRaySphere_STATIC_Ray_Vector3_float(ray, sphere_position, sphere_radius)
  end
  
  def self.check_collision_ray_sphere_ex(ray : Ray, sphere_position : Vector3, sphere_radius : Float32, collision_point : Vector3*) : Bool
    Binding.bg____CheckCollisionRaySphereEx_STATIC_Ray_Vector3_float_Vector3_X(ray, sphere_position, sphere_radius, collision_point)
  end
  
  def self.check_collision_ray_box(ray : Ray, box : BoundingBox) : Bool
    Binding.bg____CheckCollisionRayBox_STATIC_Ray_BoundingBox(ray, box)
  end
  
  def self.get_collision_ray_model(ray : Ray, model : Model*) : RayHitInfo
    RayHitInfo.new(unwrap: Binding.bg____GetCollisionRayModel_STATIC_Ray_Model_X(ray, model))
  end
  
  def self.get_collision_ray_triangle(ray : Ray, p1 : Vector3, p2 : Vector3, p3 : Vector3) : RayHitInfo
    RayHitInfo.new(unwrap: Binding.bg____GetCollisionRayTriangle_STATIC_Ray_Vector3_Vector3_Vector3(ray, p1, p2, p3))
  end
  
  def self.get_collision_ray_ground(ray : Ray, ground_height : Float32) : RayHitInfo
    RayHitInfo.new(unwrap: Binding.bg____GetCollisionRayGround_STATIC_Ray_float(ray, ground_height))
  end
  
  def self.load_text(file_name : String) : String
    Binding.bg____LoadText_STATIC_const_char_X(file_name)
  end
  
  def self.load_shader(vs_file_name : String, fs_file_name : String) : Shader
    Shader.new(unwrap: Binding.bg____LoadShader_STATIC_const_char_X_const_char_X(vs_file_name, fs_file_name))
  end
  
  def self.load_shader_code(vs_code : String, fs_code : String) : Shader
    Shader.new(unwrap: Binding.bg____LoadShaderCode_STATIC_char_X_char_X(vs_code, fs_code))
  end
  
  def self.unload_shader(shader : Shader) : Void
    Binding.bg____UnloadShader_STATIC_Shader(shader)
  end
  
  def self.get_shader_default() : Shader
    Shader.new(unwrap: Binding.bg____GetShaderDefault_STATIC_())
  end
  
  def self.get_texture_default() : Texture2D
    Texture2D.new(unwrap: Binding.bg____GetTextureDefault_STATIC_())
  end
  
  def self.get_shader_location(shader : Shader, uniform_name : String) : Int32
    Binding.bg____GetShaderLocation_STATIC_Shader_const_char_X(shader, uniform_name)
  end
  
  def self.set_shader_value(shader : Shader, uniform_loc : Int32, value : Void*, uniform_type : Int32) : Void
    Binding.bg____SetShaderValue_STATIC_Shader_int_const_void_X_int(shader, uniform_loc, value, uniform_type)
  end
  
  def self.set_shader_value_v(shader : Shader, uniform_loc : Int32, value : Void*, uniform_type : Int32, count : Int32) : Void
    Binding.bg____SetShaderValueV_STATIC_Shader_int_const_void_X_int_int(shader, uniform_loc, value, uniform_type, count)
  end
  
  def self.set_shader_value_matrix(shader : Shader, uniform_loc : Int32, mat : Matrix) : Void
    Binding.bg____SetShaderValueMatrix_STATIC_Shader_int_Matrix(shader, uniform_loc, mat)
  end
  
  def self.set_shader_value_texture(shader : Shader, uniform_loc : Int32, texture : Texture2D) : Void
    Binding.bg____SetShaderValueTexture_STATIC_Shader_int_Texture2D(shader, uniform_loc, texture)
  end
  
  def self.set_matrix_projection(proj : Matrix) : Void
    Binding.bg____SetMatrixProjection_STATIC_Matrix(proj)
  end
  
  def self.set_matrix_modelview(view : Matrix) : Void
    Binding.bg____SetMatrixModelview_STATIC_Matrix(view)
  end
  
  def self.get_matrix_modelview() : Matrix
    Matrix.new(unwrap: Binding.bg____GetMatrixModelview_STATIC_())
  end
  
  def self.gen_texture_cubemap(shader : Shader, sky_hdr : Texture2D, size : Int32) : Texture2D
    Texture2D.new(unwrap: Binding.bg____GenTextureCubemap_STATIC_Shader_Texture2D_int(shader, sky_hdr, size))
  end
  
  def self.gen_texture_irradiance(shader : Shader, cubemap : Texture2D, size : Int32) : Texture2D
    Texture2D.new(unwrap: Binding.bg____GenTextureIrradiance_STATIC_Shader_Texture2D_int(shader, cubemap, size))
  end
  
  def self.gen_texture_prefilter(shader : Shader, cubemap : Texture2D, size : Int32) : Texture2D
    Texture2D.new(unwrap: Binding.bg____GenTexturePrefilter_STATIC_Shader_Texture2D_int(shader, cubemap, size))
  end
  
  def self.gen_texture_brdf(shader : Shader, size : Int32) : Texture2D
    Texture2D.new(unwrap: Binding.bg____GenTextureBRDF_STATIC_Shader_int(shader, size))
  end
  
  def self.begin_shader_mode(shader : Shader) : Void
    Binding.bg____BeginShaderMode_STATIC_Shader(shader)
  end
  
  def self.end_shader_mode() : Void
    Binding.bg____EndShaderMode_STATIC_()
  end
  
  def self.begin_blend_mode(mode : Int32) : Void
    Binding.bg____BeginBlendMode_STATIC_int(mode)
  end
  
  def self.end_blend_mode() : Void
    Binding.bg____EndBlendMode_STATIC_()
  end
  
  def self.begin_scissor_mode(x : Int32, y : Int32, width : Int32, height : Int32) : Void
    Binding.bg____BeginScissorMode_STATIC_int_int_int_int(x, y, width, height)
  end
  
  def self.end_scissor_mode() : Void
    Binding.bg____EndScissorMode_STATIC_()
  end
  
  def self.init_vr_simulator() : Void
    Binding.bg____InitVrSimulator_STATIC_()
  end
  
  def self.close_vr_simulator() : Void
    Binding.bg____CloseVrSimulator_STATIC_()
  end
  
  def self.update_vr_tracking(camera : Binding::Camera*) : Void
    Binding.bg____UpdateVrTracking_STATIC_Camera_X(camera)
  end
  
  def self.set_vr_configuration(info : VrDeviceInfo, distortion : Shader) : Void
    Binding.bg____SetVrConfiguration_STATIC_VrDeviceInfo_Shader(info, distortion)
  end
  
  def self.is_vr_simulator_ready() : Bool
    Binding.bg____IsVrSimulatorReady_STATIC_()
  end
  
  def self.toggle_vr_mode() : Void
    Binding.bg____ToggleVrMode_STATIC_()
  end
  
  def self.begin_vr_drawing() : Void
    Binding.bg____BeginVrDrawing_STATIC_()
  end
  
  def self.end_vr_drawing() : Void
    Binding.bg____EndVrDrawing_STATIC_()
  end
  
  def self.init_audio_device() : Void
    Binding.bg____InitAudioDevice_STATIC_()
  end
  
  def self.close_audio_device() : Void
    Binding.bg____CloseAudioDevice_STATIC_()
  end
  
  def self.is_audio_device_ready() : Bool
    Binding.bg____IsAudioDeviceReady_STATIC_()
  end
  
  def self.set_master_volume(volume : Float32) : Void
    Binding.bg____SetMasterVolume_STATIC_float(volume)
  end
  
  def self.load_wave(file_name : String) : Wave
    Wave.new(unwrap: Binding.bg____LoadWave_STATIC_const_char_X(file_name))
  end
  
  def self.load_wave_ex(data : Void*, sample_count : Int32, sample_rate : Int32, sample_size : Int32, channels : Int32) : Wave
    Wave.new(unwrap: Binding.bg____LoadWaveEx_STATIC_void_X_int_int_int_int(data, sample_count, sample_rate, sample_size, channels))
  end
  
  def self.load_sound(file_name : String) : Sound
    Sound.new(unwrap: Binding.bg____LoadSound_STATIC_const_char_X(file_name))
  end
  
  def self.load_sound_from_wave(wave : Wave) : Sound
    Sound.new(unwrap: Binding.bg____LoadSoundFromWave_STATIC_Wave(wave))
  end
  
  def self.update_sound(sound : Sound, data : Void*, samples_count : Int32) : Void
    Binding.bg____UpdateSound_STATIC_Sound_const_void_X_int(sound, data, samples_count)
  end
  
  def self.unload_wave(wave : Wave) : Void
    Binding.bg____UnloadWave_STATIC_Wave(wave)
  end
  
  def self.unload_sound(sound : Sound) : Void
    Binding.bg____UnloadSound_STATIC_Sound(sound)
  end
  
  def self.export_wave(wave : Wave, file_name : String) : Void
    Binding.bg____ExportWave_STATIC_Wave_const_char_X(wave, file_name)
  end
  
  def self.export_wave_as_code(wave : Wave, file_name : String) : Void
    Binding.bg____ExportWaveAsCode_STATIC_Wave_const_char_X(wave, file_name)
  end
  
  def self.play_sound(sound : Sound) : Void
    Binding.bg____PlaySound_STATIC_Sound(sound)
  end
  
  def self.pause_sound(sound : Sound) : Void
    Binding.bg____PauseSound_STATIC_Sound(sound)
  end
  
  def self.resume_sound(sound : Sound) : Void
    Binding.bg____ResumeSound_STATIC_Sound(sound)
  end
  
  def self.stop_sound(sound : Sound) : Void
    Binding.bg____StopSound_STATIC_Sound(sound)
  end
  
  def self.is_sound_playing(sound : Sound) : Bool
    Binding.bg____IsSoundPlaying_STATIC_Sound(sound)
  end
  
  def self.set_sound_volume(sound : Sound, volume : Float32) : Void
    Binding.bg____SetSoundVolume_STATIC_Sound_float(sound, volume)
  end
  
  def self.set_sound_pitch(sound : Sound, pitch : Float32) : Void
    Binding.bg____SetSoundPitch_STATIC_Sound_float(sound, pitch)
  end
  
  def self.wave_format(wave : Wave*, sample_rate : Int32, sample_size : Int32, channels : Int32) : Void
    Binding.bg____WaveFormat_STATIC_Wave_X_int_int_int(wave, sample_rate, sample_size, channels)
  end
  
  def self.wave_copy(wave : Wave) : Wave
    Wave.new(unwrap: Binding.bg____WaveCopy_STATIC_Wave(wave))
  end
  
  def self.wave_crop(wave : Wave*, init_sample : Int32, final_sample : Int32) : Void
    Binding.bg____WaveCrop_STATIC_Wave_X_int_int(wave, init_sample, final_sample)
  end
  
  def self.get_wave_data(wave : Wave) : Float32*
    Binding.bg____GetWaveData_STATIC_Wave(wave)
  end
  
  def self.load_music_stream(file_name : String) : Binding::MusicData*
    Binding.bg____LoadMusicStream_STATIC_const_char_X(file_name)
  end
  
  def self.unload_music_stream(music : Binding::MusicData*) : Void
    Binding.bg____UnloadMusicStream_STATIC_Music(music)
  end
  
  def self.play_music_stream(music : Binding::MusicData*) : Void
    Binding.bg____PlayMusicStream_STATIC_Music(music)
  end
  
  def self.update_music_stream(music : Binding::MusicData*) : Void
    Binding.bg____UpdateMusicStream_STATIC_Music(music)
  end
  
  def self.stop_music_stream(music : Binding::MusicData*) : Void
    Binding.bg____StopMusicStream_STATIC_Music(music)
  end
  
  def self.pause_music_stream(music : Binding::MusicData*) : Void
    Binding.bg____PauseMusicStream_STATIC_Music(music)
  end
  
  def self.resume_music_stream(music : Binding::MusicData*) : Void
    Binding.bg____ResumeMusicStream_STATIC_Music(music)
  end
  
  def self.is_music_playing(music : Binding::MusicData*) : Bool
    Binding.bg____IsMusicPlaying_STATIC_Music(music)
  end
  
  def self.set_music_volume(music : Binding::MusicData*, volume : Float32) : Void
    Binding.bg____SetMusicVolume_STATIC_Music_float(music, volume)
  end
  
  def self.set_music_pitch(music : Binding::MusicData*, pitch : Float32) : Void
    Binding.bg____SetMusicPitch_STATIC_Music_float(music, pitch)
  end
  
  def self.set_music_loop_count(music : Binding::MusicData*, count : Int32) : Void
    Binding.bg____SetMusicLoopCount_STATIC_Music_int(music, count)
  end
  
  def self.get_music_time_length(music : Binding::MusicData*) : Float32
    Binding.bg____GetMusicTimeLength_STATIC_Music(music)
  end
  
  def self.get_music_time_played(music : Binding::MusicData*) : Float32
    Binding.bg____GetMusicTimePlayed_STATIC_Music(music)
  end
  
  def self.init_audio_stream(sample_rate : Int32, sample_size : Int32, channels : Int32) : AudioStream
    AudioStream.new(unwrap: Binding.bg____InitAudioStream_STATIC_unsigned_int_unsigned_int_unsigned_int(sample_rate, sample_size, channels))
  end
  
  def self.update_audio_stream(stream : AudioStream, data : Void*, samples_count : Int32) : Void
    Binding.bg____UpdateAudioStream_STATIC_AudioStream_const_void_X_int(stream, data, samples_count)
  end
  
  def self.close_audio_stream(stream : AudioStream) : Void
    Binding.bg____CloseAudioStream_STATIC_AudioStream(stream)
  end
  
  def self.is_audio_buffer_processed(stream : AudioStream) : Bool
    Binding.bg____IsAudioBufferProcessed_STATIC_AudioStream(stream)
  end
  
  def self.play_audio_stream(stream : AudioStream) : Void
    Binding.bg____PlayAudioStream_STATIC_AudioStream(stream)
  end
  
  def self.pause_audio_stream(stream : AudioStream) : Void
    Binding.bg____PauseAudioStream_STATIC_AudioStream(stream)
  end
  
  def self.resume_audio_stream(stream : AudioStream) : Void
    Binding.bg____ResumeAudioStream_STATIC_AudioStream(stream)
  end
  
  def self.is_audio_stream_playing(stream : AudioStream) : Bool
    Binding.bg____IsAudioStreamPlaying_STATIC_AudioStream(stream)
  end
  
  def self.stop_audio_stream(stream : AudioStream) : Void
    Binding.bg____StopAudioStream_STATIC_AudioStream(stream)
  end
  
  def self.set_audio_stream_volume(stream : AudioStream, volume : Float32) : Void
    Binding.bg____SetAudioStreamVolume_STATIC_AudioStream_float(stream, volume)
  end
  
  def self.set_audio_stream_pitch(stream : AudioStream, pitch : Float32) : Void
    Binding.bg____SetAudioStreamPitch_STATIC_AudioStream_float(stream, pitch)
  end
  
  module Enum
    enum Key : Int32
      Apostrophe = 39
      Comma = 44
      Minus = 45
      Period = 46
      Slash = 47
      Zero = 48
      One = 49
      Two = 50
      Three = 51
      Four = 52
      Five = 53
      Six = 54
      Seven = 55
      Eight = 56
      Nine = 57
      Semicolon = 59
      Equal = 61
      A = 65
      B = 66
      C = 67
      D = 68
      E = 69
      F = 70
      G = 71
      H = 72
      I = 73
      J = 74
      K = 75
      L = 76
      M = 77
      N = 78
      O = 79
      P = 80
      Q = 81
      R = 82
      S = 83
      T = 84
      U = 85
      V = 86
      W = 87
      X = 88
      Y = 89
      Z = 90
      Space = 32
      Escape = 256
      Enter = 257
      Tab = 258
      Backspace = 259
      Insert = 260
      Delete = 261
      Right = 262
      Left = 263
      Down = 264
      Up = 265
      PageUp = 266
      PageDown = 267
      Home = 268
      End = 269
      CapsLock = 280
      ScrollLock = 281
      NumLock = 282
      PrintScreen = 283
      Pause = 284
      F1 = 290
      F2 = 291
      F3 = 292
      F4 = 293
      F5 = 294
      F6 = 295
      F7 = 296
      F8 = 297
      F9 = 298
      F10 = 299
      F11 = 300
      F12 = 301
      LeftShift = 340
      LeftControl = 341
      LeftAlt = 342
      LeftSuper = 343
      RightShift = 344
      RightControl = 345
      RightAlt = 346
      RightSuper = 347
      KbMenu = 348
      LeftBracket = 91
      Backslash = 92
      RightBracket = 93
      Grave = 96
      Kp0 = 320
      Kp1 = 321
      Kp2 = 322
      Kp3 = 323
      Kp4 = 324
      Kp5 = 325
      Kp6 = 326
      Kp7 = 327
      Kp8 = 328
      Kp9 = 329
      KpDecimal = 330
      KpDivide = 331
      KpMultiply = 332
      KpSubtract = 333
      KpAdd = 334
      KpEnter = 335
      KpEqual = 336
    end
    enum Config : Int32
      ShowLogo = 1
      FullscreenMode = 2
      WindowResizable = 4
      WindowUndecorated = 8
      WindowTransparent = 16
      WindowHidden = 128
      Msaa4xHint = 32
      VsyncHint = 64
    end
    enum TraceLog : Int32
      All = 0
      Trace = 1
      Debug = 2
      Info = 3
      Warning = 4
      Error = 5
      Fatal = 6
      None = 7
    end
    module Android
      enum Key : Int32
        Back = 4
        Menu = 82
        VolumeUp = 24
        VolumeDown = 25
      end
    end
    module Mouse
      enum Key : Int32
        LeftButton = 0
        RightButton = 1
        MiddleButton = 2
      end
    end
    module Gamepad
      enum Number : Int32
        Player1 = 0
        Player2 = 1
        Player3 = 2
        Player4 = 3
      end
      enum Button : Int32
        Unknown = 0
        LeftFaceUp = 1
        LeftFaceRight = 2
        LeftFaceDown = 3
        LeftFaceLeft = 4
        RightFaceUp = 5
        RightFaceRight = 6
        RightFaceDown = 7
        RightFaceLeft = 8
        LeftTrigger1 = 9
        LeftTrigger2 = 10
        RightTrigger1 = 11
        RightTrigger2 = 12
        MiddleLeft = 13
        Middle = 14
        MiddleRight = 15
        LeftThumb = 16
        RightThumb = 17
      end
      enum Axis : Int32
        Unknown = 0
        LeftX = 1
        LeftY = 2
        RightX = 3
        RightY = 4
        LeftTrigger = 5
        RightTrigger = 6
      end
    end
    module Shader
      enum Location : Int32
        VertexPosition = 0
        VertexTexcoord01 = 1
        VertexTexcoord02 = 2
        VertexNormal = 3
        VertexTangent = 4
        VertexColor = 5
        MatrixMvp = 6
        MatrixModel = 7
        MatrixView = 8
        MatrixProjection = 9
        VectorView = 10
        ColorDiffuse = 11
        ColorSpecular = 12
        ColorAmbient = 13
        MapAlbedo = 14
        MapMetalness = 15
        MapNormal = 16
        MapRoughness = 17
        MapOcclusion = 18
        MapEmission = 19
        MapHeight = 20
        MapCubemap = 21
        MapIrradiance = 22
        MapPrefilter = 23
        MapBrdf = 24
      end
      module UniformData
        enum Type : Int32
          Float = 0
          Vec2 = 1
          Vec3 = 2
          Vec4 = 3
          Int = 4
          Ivec2 = 5
          Ivec3 = 6
          Ivec4 = 7
          Sampler2d = 8
        end
      end
    end
    module Material
      module Map
        enum Type : Int32
          Albedo = 0
          Metalness = 1
          Normal = 2
          Roughness = 3
          Occlusion = 4
          Emission = 5
          Height = 6
          Cubemap = 7
          Irradiance = 8
          Prefilter = 9
          Brdf = 10
        end
      end
    end
    module Pixel
      enum Format : Int32
        UncompressedGrayscale = 1
        UncompressedGrayAlpha = 2
        UncompressedR5g6b5 = 3
        UncompressedR8g8b8 = 4
        UncompressedR5g5b5a1 = 5
        UncompressedR4g4b4a4 = 6
        UncompressedR8g8b8a8 = 7
        UncompressedR32 = 8
        UncompressedR32g32b32 = 9
        UncompressedR32g32b32a32 = 10
        CompressedDxt1Rgb = 11
        CompressedDxt1Rgba = 12
        CompressedDxt3Rgba = 13
        CompressedDxt5Rgba = 14
        CompressedEtc1Rgb = 15
        CompressedEtc2Rgb = 16
        CompressedEtc2EacRgba = 17
        CompressedPvrtRgb = 18
        CompressedPvrtRgba = 19
        CompressedAstc4x4Rgba = 20
        CompressedAstc8x8Rgba = 21
      end
    end
    module Texture
      module Filter
        enum Mode : Int32
          Point = 0
          Bilinear = 1
          Trilinear = 2
          Anisotropic4x = 3
          Anisotropic8x = 4
          Anisotropic16x = 5
        end
      end
      module Wrap
        enum Mode : Int32
          Repeat = 0
          Clamp = 1
          MirrorRepeat = 2
          MirrorClamp = 3
        end
      end
    end
    module Cubemap
      enum Layout : Int32
        AutoDetect = 0
        LineVertical = 1
        LineHorizontal = 2
        CrossThreeByFour = 3
        CrossFourByThree = 4
        Panorama = 5
      end
    end
    module Font
      enum Type : Int32
        Default = 0
        Bitmap = 1
        Sdf = 2
      end
    end
    module Blend
      enum Mode : Int32
        Alpha = 0
        Additive = 1
        Multiplied = 2
      end
    end
    module Gesture
      enum Type : Int32
        None = 0
        Tap = 1
        Doubletap = 2
        Hold = 4
        Drag = 8
        SwipeRight = 16
        SwipeLeft = 32
        SwipeUp = 64
        SwipeDown = 128
        PinchIn = 256
        PinchOut = 512
      end
    end
    module Camera
      enum Mode : Int32
        Custom = 0
        Free = 1
        Orbital = 2
        FirstPerson = 3
        ThirdPerson = 4
      end
      enum Type : Int32
        Perspective = 0
        Orthographic = 1
      end
    end
    module NPatch
      enum Type : Int32
        Digit9PATCH = 0
        Digit3PATCHVERTICAL = 1
        Digit3PATCHHORIZONTAL = 2
      end
    end
  end
end
