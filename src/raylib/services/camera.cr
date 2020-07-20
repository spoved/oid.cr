class RayLib::CameraService
  include Oid::Service::Camera

  private property camera : RayLib::Camera2D | RayLib::Camera3D = RayLib::Camera2D.new(
    target: Vector2.new(x: 0.0f32, y: 0.0f32),
    offset: Vector2.new(x: 0.0f32, y: 0.0f32),
    rotation: 0.0f32,
    zoom: 1.0f32
  )

  def begin_camera_mode
    # puts "begin_camera_mode"

    case self.camera
    when RayLib::Camera2D
      RayLib::Camera.begin_mode_2d(self.camera.as(RayLib::Camera2D))
    when RayLib::Camera3D
      RayLib::Camera.begin_mode_3d(self.camera.as(RayLib::Camera3D))
    else
      raise "Unknown Camera: #{self.camera.inspect}"
    end
  end

  def end_camera_mode
    # puts "end_camera_mode"

    case self.camera
    when RayLib::Camera2D
      RayLib::Camera.end_mode_2d
    when RayLib::Camera3D
      RayLib::Camera.end_mode_3d
    else
      raise "Unknown Camera: #{self.camera.inspect}"
    end
  end

  def set_camera_mode(mode : Oid::Components::Camera::Mode)
    RayLib.set_camera_mode(camera.as(RayLib::Camera3D), mode.value) if camera.is_a?(RayLib::Camera3D)
  end

  def update_camera(entity : StageEntity)
    # puts "update camera"
    if entity.camera.is_3d?
      # puts "update 3d camera"
      self.camera = camera3d(entity)
      RayLib::Camera.update(self.camera.as(RayLib::Camera3D))
    else
      self.camera = camera2d(entity)
    end
  end

  private def camera2d(entity) : RayLib::Camera2D
    self.class.camera2d(entity)
  end

  def self.camera2d(entity) : RayLib::Camera2D
    RayLib::Camera2D.new(
      target: RayLib::Vector2.new(entity.camera.target.to_v2),
      offset: RayLib::Vector2.new(entity.camera.offset.to_v2),
      rotation: entity.rotation_norm.x.to_f32,
      zoom: entity.camera.zoom.to_f32,
    )
  end

  private def camera3d(entity) : RayLib::Camera3D
    self.class.camera3d(entity)
  end

  def self.camera3d(entity) : RayLib::Camera3D
    RayLib::Camera3D.new(
      target: RayLib::Vector3.new(entity.camera.target),
      position: RayLib::Vector3.new(entity.position.value),
      up: RayLib::Vector3.new(entity.rotation.value),
      fovy: entity.camera.fov.to_f32,
      type: entity.camera.type.value
    )
  end
end
