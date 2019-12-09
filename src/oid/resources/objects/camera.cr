module Oid
  module Camera
    include JSON::Serializable
    include Oid::Transformable

    setter target : Oid::GameObject? = nil

    def target
      raise "Camera does not have a target!" if @target.nil?
      @target.as(Oid::GameObject)
    end

    def parent : Oid::Transformable
      self.target
    end

    def root : Oid::Transformable
      self.target
    end

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
    property rotation : Oid::Vector3

    # Camera zoom
    property zoom : Float64

    def initialize(
      @target : Oid::GameObject? = nil,
      @offset : Oid::Vector2 = Oid::Vector2.zero,
      @rotation : Oid::Vector3 = Oid::Vector3.zero,
      @zoom : Float64 = 1.0
    ); end
  end
end
