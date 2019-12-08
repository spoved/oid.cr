class RayLib::ViewSystem
  include Oid::Service::View

  private property camera : RayLib::Camera2D | RayLib::Camera3D = RayLib::Camera2D.new(
    target: Vector2.new(
      x: 0.0f32,
      y: 0.0f32,
    ),
    offset: Vector2.new(
      x: 0.0f32,
      y: 0.0f32,
    ),
    rotation: 0.0f32,
    zoom: 1.0f32
  )

  private property textures : Hash(String, RayLib::Texture2D) = Hash(String, RayLib::Texture2D).new

  def update_camera(camera : Oid::Camera)
    case camera
    when Oid::Camera2D
      self.camera = RayLib::Camera2D.new(camera)
    when Oid::Camera3D
      self.camera = RayLib::Camera3D.new(camera)
    else
      raise "Unknown camera class: #{camera.class}"
    end
  end

  def load_asset(
    contexts : Contexts,
    entity : Entitas::IEntity,
    asset_type : Oid::Enum::AssetType,
    asset_name : String
  )
    # TODO FINISH
    case asset_type
    when Oid::Enum::AssetType::Texture
      unless textures[asset_name]?
        textures[asset_name] = RayLib.load_texture(
          File.join(contexts.meta.config_service.instance.asset_path, asset_name)
        )
      end
    end
    entity.add_component_view(scale: 0.4)
    # contexts.game.create_entity.add_actor.add_position(Oid::Vector3.new(1.0, 1.0, 0.0))
  end

  def render(contexts : Contexts, entity : Entitas::IEntity)
    e = entity.as(GameEntity)
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
    end
  end

  def end_camera_mode
    case self.camera
    when RayLib::Camera2D
      RayLib::Camera.end_mode_2d
    when RayLib::Camera3D
      RayLib::Camera.end_mode_3d
    end
  end
end
