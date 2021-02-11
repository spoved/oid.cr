require "xml"

class RayLib::ViewService
  include Oid::Service::View

  alias AtlasSubTexture = NamedTuple(name: String, x: Float32, y: Float32, width: Float32, height: Float32)

  @[JSON::Field(ignore: true)]
  getter textures : Hash(String, RayLib::Texture2D) = Hash(String, RayLib::Texture2D).new
  @[JSON::Field(ignore: true)]
  getter texture_links : Hash(String, Entitas::UnsafeAERC) = Hash(String, Entitas::UnsafeAERC).new
  @[JSON::Field(ignore: true)]
  getter texture_atlases : Hash(String, Hash(String, AtlasSubTexture)) = Hash(String, Hash(String, AtlasSubTexture)).new

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

  def load_texture_atlas(path, name, entity)
    # Atlas already exists
    if textures[name]?
      # Retain it
      texture_links[name].retain(entity)
    else
      xml_file = File.join(path, name)
      document = XML.parse(File.read(xml_file))
      raise "Unable to load atlas at #{xml_file}" if document.nil?
      atlas = document.first_element_child
      raise "Unable to load atlas at #{xml_file}" unless atlas
      raise "Unable to load atlas at #{xml_file}" unless atlas.name == "TextureAtlas"

      texture_atlases[name] = Hash(String, AtlasSubTexture).new

      # Search for all subtextures
      atlas.children.each do |child|
        next unless child.element?
        next unless child.name == "SubTexture"
        t = {
          name:   child["name"],
          x:      child["x"].to_f32,
          y:      child["y"].to_f32,
          width:  child["width"].to_f32,
          height: child["height"].to_f32,
        }

        texture_atlases[name][t[:name]] = t
      end

      img_path = File.join(File.dirname(xml_file), atlas["imagePath"])
      # Need to load it
      textures[name] = RayLib.load_texture(img_path)
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
    texture_atlases.each do |n, textures|
      textures.each do |sub_name, info|
        if sub_name == name
          return {texture(n), info}
        end
      end
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
