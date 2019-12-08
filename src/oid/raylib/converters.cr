require "../resources/objects"

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

  struct Camera2D
    def self.new(camera : Oid::Camera2D)
      RayLib::Camera2D.new(
        target: camera.target.nil? ? Vector2.new(0.0f32, 0.0f32) : Vector2.new(camera.target.as(Oid::GameObject).position),
        offset: Vector2.new(camera.offset),
        rotation: camera.rotation.to_f32,
        zoom: camera.zoom.to_f32
      )
    end
  end

  struct Camera3D
    def self.new(camera : Oid::Camera3D)
      RayLib::Camera3D.new(
        target: camera.target.nil? ? Vector3.new(0.0f32, 0.0f32, 0.0f32) : Vector3.new(camera.target.as(Oid::GameObject).position),
        position: Vector3.new(camera.position),
        up: Vector3.new(camera.rotation),
        fovy: camera.fov_y.to_f32,
        type: camera.type.value
      )
    end
  end
end
