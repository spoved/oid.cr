module Oid
  module Camera
    enum Mode
      Mode2D
      Mode3D
    end

    abstract def mode : Oid::Camera::Mode
    abstract def mode=(value : Oid::Camera::Mode)

    abstract def target : Oid::Vector3
    abstract def target=(value : Oid::Vector3)

    abstract def offset : Oid::Vector3
    abstract def offset=(value : Oid::Vector3)

    abstract def rotation : Float64
    abstract def rotation=(value : Float64)

    abstract def zoom : Float64
    abstract def zoom=(value : Float64)
  end
end
