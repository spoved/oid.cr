module Oid
  # Position, rotation and scale of an object.
  class Transform
    property position : RayLib::Vector3 = RayLib::Vector3.zero
    property rotation : RayLib::Quaternion = RayLib::Quaternion.zero

    def position=(value : RayLib::Vector2)
      self.position = value.to_v3
    end
  end
end
