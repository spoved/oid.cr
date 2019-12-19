require "../resources/**"

module RayLib
  struct Vector2
    def self.new(value : Oid::Vector2 | Oid::Vector3)
      RayLib::Vector2.new(
        x: value.x.to_f32,
        y: value.y.to_f32
      )
    end
  end

  struct Vector3
    def self.new(value : Oid::Vector2 | Oid::Vector3)
      RayLib::Vector3.new(
        x: value.x.to_f32,
        y: value.y.to_f32,
        z: value.is_a?(Oid::Vector3) ? value.z.to_f32 : 0.0f32
      )
    end
  end
end
