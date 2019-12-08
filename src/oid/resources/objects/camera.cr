module Oid
  module Camera
    include JSON::Serializable

    property target : Oid::GameObject? = nil

    enum Mode
      Custom
      Free
      Orbital
      FirstPerson
      ThirdPerson
    end

    enum Type
      Perspective
      Orthographic
    end
  end

  class Camera3D
    include Oid::Camera

    # Camera position
    property position : Oid::Vector3

    # Camera up vector (rotation towards target)
    property rotation : Oid::Vector3

    # Camera field-of-view Y
    property fov_y : Float64

    # Camera type: Perspective or Orthographic
    property type : Oid::Camera::Type

    def initialize(
      @target : Oid::GameObject? = nil,
      @position : Oid::Vector3 = Oid::Vector3.zero,
      @rotation : Oid::Vector3 = Oid::Vector3.zero,
      @fov_y : Float64 = 50.0,
      @type : Oid::Camera::Type = Oid::Camera::Type::Perspective
    ); end
  end

  class Camera2D
    include Oid::Camera

    # Camera offset from target
    property offset : Oid::Vector2

    # Camera rotation towards target
    property rotation : Float64

    # Camera zoom
    property zoom : Float64

    def initialize(
      @target : Oid::GameObject? = nil,
      @offset : Oid::Vector2 = Oid::Vector2.zero,
      @rotation : Float64 = 0.0,
      @zoom : Float64 = 1.0
    ); end
  end
end
