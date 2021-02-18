class RayLib::ViewService
  include Oid::Service::View
  include RayLib::Handler::TextureAtlas

  @[JSON::Field(ignore: true)]
  getter textures : Hash(String, RayLib::Texture2D) = Hash(String, RayLib::Texture2D).new
  @[JSON::Field(ignore: true)]
  getter texture_links : Hash(String, Entitas::UnsafeAERC) = Hash(String, Entitas::UnsafeAERC).new

  protected setter root_view : StageEntity? = nil

  def init_controller(contexts : Contexts, entity : Oid::RenderableEntity) : Oid::Controller::View
    RayLib::ViewController.new(contexts, entity)
  end

  def get_root_view(contexts : Contexts) : StageEntity
    @root_view ||= contexts.stage.create_entity
      .add_position(
        Oid::Vector3.new(
          x: -(contexts.meta.config_service.instance.screen_w/2),
          y: -(contexts.meta.config_service.instance.screen_h/2),
          z: 0.0
        )
      )
      .add_root_view
  end

  def load_texture(path, name, entity)
    # Texture already exists
    if textures[name]?
      # Retain it
      texture_links[name].retain(entity)
    else
      # Need to load it
      textures[name] = RayLib.load_texture(File.join(path, name))
      # Create the AERC
      texture_links[name] = Entitas::UnsafeAERC.new
      # Then retain it
      texture_links[name].retain(entity)
    end
  end

  def unload_texture(name, entity)
    if textures[name]?
      texture_links[name].release(entity)
      if texture_links[name].retain_count <= 0
        RayLib.unload_texture(textures[name])
      end
      textures.delete(name)
      texture_links.delete(name)
    end
  end

  def texture(name) : RayLib::Texture2D?
    textures[name]?
  end

  def sub_texture(name) : Tuple(RayLib::Texture2D?, AtlasSubTexture?)
    if texture_atlas_map[name]?
      return {texture(texture_atlas_map[name]), sub_texture_info[name]}
    end

    {nil, nil}
  end

  def get_ray_from(position : Oid::Vector2, camera : StageEntity) : Oid::Ray
    ray = RayLib.get_mouse_ray(
      RayLib::Vector2.new(position),
      RayLib::CameraService.camera3d(camera)
    )

    Oid::Ray.new(
      Oid::Vector3.new(
        ray.position.x,
        ray.position.y,
        ray.position.z,
      ),
      Oid::Vector3.new(
        ray.direction.x,
        ray.direction.y,
        ray.direction.z,
      ),
    )
  end
end
