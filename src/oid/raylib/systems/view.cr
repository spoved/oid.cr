class RayLib::ViewSystem
  include Oid::Service::View

  private property camera : RayLib::Camera2D | RayLib::Camera3D = RayLib::Camera2D.new(
    target: Vector2.new(x: 0.0f32, y: 0.0f32),
    offset: Vector2.new(x: 0.0f32, y: 0.0f32),
    rotation: 0.0f32,
    zoom: 1.0f32
  )

  private property textures : Hash(String, RayLib::Texture2D) = Hash(String, RayLib::Texture2D).new

  def camera2d : RayLib::Camera2D
    self.camera.as(RayLib::Camera2D)
  end

  def set_camera_mode(value : Oid::Camera3D)
    RayLib.set_camera_mode(RayLib::Camera3D.new(value), value.mode.value)
  end

  def update_camera(value : Oid::Camera)
    case value
    when Oid::Camera2D
      self.camera = RayLib::Camera2D.new(value)
    when Oid::Camera3D
      self.camera = RayLib::Camera3D.new(value)
    else
      raise "Unknown Camera: #{value.inspect}"
    end
  end

  def load_asset(contexts : Contexts, entity : Entitas::IEntity, asset_type : Oid::Enum::AssetType, asset_name : String)
    # TODO FINISH
    case asset_type
    when Oid::Enum::AssetType::Texture
      unless textures[asset_name]?
        textures[asset_name] = RayLib.load_texture(
          File.join(contexts.meta.config_service.instance.asset_path, asset_name)
        )
      end
    end
    entity.add_view(scale: 0.4)
  end

  def render(contexts : Contexts, entity : Entitas::IEntity)
    e = entity.as(GameEntity)
    if e.asset?
      render_asset(e)
    end

    if e.actor?
      e.actor.each_child do |child|
        render_actor(e, child)
      end
    end
  end

  private def render_actor(entity, object)
    case object
    when Oid::Rectangle
      RayLib.draw_rectangle_pro(
        rec: RayLib::Rectangle.new(
          x: object.transform.x.to_f32,
          y: object.transform.y.to_f32,
          width: object.width.to_f32,
          height: object.height.to_f32,
        ),
        origin: RayLib::Vector2.new(0, 0),
        rotation: object.rotation.x.to_f32,
        color: object.color.to_unsafe,
      )
    when Oid::Line
      end_pos = (Oid::Matrix::Mat4.unit.translate(object.parent.position) * object.end_pos.to_v3.to_v4).to_v3

      RayLib.draw_line(
        start_pos_x: object.transform.x.to_i,
        start_pos_y: object.transform.y.to_i,
        end_pos_x: end_pos.x.to_i,
        end_pos_y: end_pos.y.to_i,
        color: object.color.to_unsafe,
      )
    when Oid::Cube
      RayLib.draw_cube(
        position: RayLib::Vector3.new(object.transform),
        width: object.size.x.to_f32,
        height: object.size.y.to_f32,
        length: object.size.z.to_f32,
        color: object.color.to_unsafe,
      )
    when Oid::CubeWires
      RayLib.draw_cube_wires(
        position: RayLib::Vector3.new(object.transform),
        width: object.size.x.to_f32,
        height: object.size.y.to_f32,
        length: object.size.z.to_f32,
        color: object.color.to_unsafe,
      )
    when Oid::Grid
      RayLib.draw_grid(
        slices: object.size,
        spacing: object.spacing.to_f32,
      )
    end
  end

  private def render_asset(e)
    case e.asset.type
    when Oid::Enum::AssetType::Texture
      RayLib.draw_texture_ex(
        texture: textures[e.asset.name],
        position: RayLib::Vector2.new(
          e.position.value.x.to_f32 * (800/10),
          e.position.value.y.to_f32 * (600/10),
        ),
        rotation: e.view.rotation.to_f32,
        scale: e.view.scale.to_f32,
        tint: Oid::Color::WHITE.to_unsafe
      )
    end
  end

  def render_fps
    RayLib.draw_fps(10, 10)
  end

  def begin_camera_mode
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
    case self.camera
    when RayLib::Camera2D
      RayLib::Camera.end_mode_2d
    when RayLib::Camera3D
      RayLib::Camera.end_mode_3d
    else
      raise "Unknown Camera: #{self.camera.inspect}"
    end
  end
end
