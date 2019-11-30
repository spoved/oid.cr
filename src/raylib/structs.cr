require "json"

private macro raylib_converter
  include JSON::Serializable

  {% name = @type.name.gsub(/RayLib::/, "") %}

  def self.new(unwrap : ::Pointer(Binding::{{name}}))
    unwrap.as(Pointer({{name}})).value
  end

  def self.new(unwrap : Binding::{{name}})
    unwrap.unsafe_as({{name}})
  end

  def to_unsafe
    unsafe_as(Binding::{{name}})
  end
end

module RayLib
  struct Vector2
    property x : Float32
    property y : Float32

    def initialize(@x : Float32, @y : Float32); end

    raylib_converter
  end

  struct Vector3
    property x : Float32
    property y : Float32
    property z : Float32

    def initialize(@x : Float32, @y : Float32, @z : Float32); end

    raylib_converter
  end

  struct Vector4
    property x : Float32
    property y : Float32
    property z : Float32
    property w : Float32

    def initialize(@x : Float32, @y : Float32, @z : Float32, @w : Float32); end

    raylib_converter
  end

  # A quaternion that stores the rotation of the Transform in world space.
  alias Quaternion = Vector4

  struct Matrix
    property m0 : Float32
    property m4 : Float32
    property m8 : Float32
    property m12 : Float32
    property m1 : Float32
    property m5 : Float32
    property m9 : Float32
    property m13 : Float32
    property m2 : Float32
    property m6 : Float32
    property m10 : Float32
    property m14 : Float32
    property m3 : Float32
    property m7 : Float32
    property m11 : Float32
    property m15 : Float32

    def initialize(@m0, @m4, @m8, @m12, @m1, @m5, @m9, @m13, @m2, @m6, @m10, @m14, @m3, @m7, @m11, @m15); end

    raylib_converter
  end

  struct Rectangle
    property x : Float32
    property y : Float32
    property width : Float32
    property height : Float32

    def initialize(@x, @y, @width, @height); end

    raylib_converter
  end

  struct Image
    property data : Void*
    property width : Int32
    property height : Int32
    property mipmaps : Int32
    property format : Int32

    def initialize(@data, @width, @height, @mipmaps, @format); end

    raylib_converter
  end

  struct Texture2D
    property id : LibC::UInt
    property width : Int32
    property height : Int32
    property mipmaps : Int32
    property format : Int32

    def initialize(@id, @width, @height, @mipmaps, @format); end

    raylib_converter
  end

  struct RenderTexture2D
    property id : LibC::UInt
    property texture : Texture2D
    property depth : Texture2D
    property depth_texture : Bool

    def initialize(@id, @texture, @depth, @depth_texture); end

    raylib_converter
  end

  struct NPatchInfo
    property source_rec : Rectangle
    property left : Int32
    property top : Int32
    property right : Int32
    property bottom : Int32
    property type : Int32

    def initialize(@source_rec, @left, @top, @right, @bottom, @type); end

    raylib_converter
  end

  struct CharInfo
    property value : Int32
    property rec : Rectangle
    property offset_x : Int32
    property offset_y : Int32
    property advance_x : Int32
    property data : UInt8

    def initialize(@value, @rec, @offset_x, @offset_y, @advance_x, @data); end

    raylib_converter
  end

  struct Font
    property texture : Texture2D
    property base_size : Int32
    property chars_count : Int32
    property chars : CharInfo

    def initialize(@texture, @base_size, @chars_count, @chars); end

    raylib_converter
  end

  struct Camera3D
    property position : Vector3
    property target : Vector3
    property up : Vector3
    property fovy : Float32
    property type : Int32

    def initialize(@position, @target, @up, @fovy, @type); end

    raylib_converter
  end

  struct Camera2D
    property offset : Vector2
    property target : Vector2
    property rotation : Float32
    property zoom : Float32

    def initialize(@offset, @target, @rotation, @zoom); end

    raylib_converter
  end

  struct Mesh
    property vertex_count : Int32
    property triangle_count : Int32
    property vertices : Float32
    property texcoords : Float32
    property texcoords2 : Float32
    property normals : Float32
    property tangents : Float32
    property colors : UInt8
    property indices : UInt16
    property anim_vertices : Float32
    property anim_normals : Float32
    property bone_ids : Int32
    property bone_weights : Float32
    property vao_id : LibC::UInt
    property vbo_id : LibC::UInt[7]

    def initialize(@vertex_count, @triangle_count, @vertices, @texcoords, @texcoords2,
                   @normals, @tangents, @colors, @indices, @anim_vertices, @anim_normals,
                   @bone_ids, @bone_weights, @vao_id, @vbo_id); end

    raylib_converter
  end

  struct Shader
    property id : LibC::UInt
    property locs : LibC::Int[32]

    def initialize(@id, @locs); end

    raylib_converter
  end

  struct MaterialMap
    property texture : Texture2D
    property color : RayLib::Binding::Color
    property value : Float32

    def initialize(@texture, @color, @value); end

    raylib_converter
  end

  struct Material
    property shader : Shader
    property maps : MaterialMap[12]
    property params : Float32

    def initialize(@shader, @maps, @params); end

    raylib_converter
  end

  struct Transform
    property translation : Vector3
    property rotation : Vector4
    property scale : Vector3

    def initialize(@translation, @rotation, @scale); end

    raylib_converter
  end

  struct BoneInfo
    property name : LibC::Char[32]
    property parent : Int32

    def initialize(@name, @parent); end

    raylib_converter
  end

  struct Model
    property transform : Matrix
    property mesh_count : Int32
    property meshes : Mesh
    property material_count : Int32
    property materials : Material
    property mesh_material : Int32
    property bone_count : Int32
    property bones : BoneInfo
    property bind_pose : Transform

    def initialize(@transform, @mesh_count, @meshes, @material_count,
                   @materials, @mesh_material, @bone_count, @bones, @bind_pose); end

    raylib_converter
  end

  struct ModelAnimation
    property bone_count : Int32
    property bones : BoneInfo
    property frame_count : Int32
    property frame_poses : Transform

    def initialize(@bone_count, @bones, @frame_count, @frame_poses); end

    raylib_converter
  end

  struct Ray
    property position : Vector3
    property direction : Vector3

    def initialize(@position, @direction); end

    raylib_converter
  end

  struct RayHitInfo
    property hit : Bool
    property distance : Float32
    property position : Vector3
    property normal : Vector3

    def initialize(@hit, @distance, @position, @normal); end

    raylib_converter
  end

  struct BoundingBox
    property min : Vector3
    property max : Vector3

    def initialize(@min, @max); end

    raylib_converter
  end

  struct Wave
    property sample_count : LibC::UInt
    property sample_rate : LibC::UInt
    property sample_size : LibC::UInt
    property channels : LibC::UInt
    property data : Void*

    def initialize(@sample_count, @sample_rate, @sample_size, @channels, @data); end

    raylib_converter
  end

  struct Sound
    property audio_buffer : Void*
    property source : LibC::UInt
    property buffer : LibC::UInt
    property format : Int32

    def initialize(@audio_buffer, @source, @buffer, @format); end

    raylib_converter
  end

  struct AudioStream
    property sample_rate : LibC::UInt
    property sample_size : LibC::UInt
    property channels : LibC::UInt
    property audio_buffer : Void*
    property format : Int32
    property source : LibC::UInt
    property buffers : LibC::UInt[2]

    def initialize(@sample_rate, @sample_size, @channels, @audio_buffer,
                   @format, @source, @buffers); end

    raylib_converter
  end

  struct VrDeviceInfo
    property h_resolution : Int32
    property v_resolution : Int32
    property h_screen_size : Float32
    property v_screen_size : Float32
    property v_screen_center : Float32
    property eye_to_screen_distance : Float32
    property lens_separation_distance : Float32
    property interpupillary_distance : Float32
    property lens_distortion_values : LibC::Float[4]
    property chroma_ab_correction : LibC::Float[4]

    def initialize(@h_resolution, @v_resolution, @h_screen_size, @v_screen_size,
                   @v_screen_center, @eye_to_screen_distance, @lens_separation_distance,
                   @interpupillary_distance, @lens_distortion_values, @chroma_ab_correction); end

    raylib_converter
  end
end
