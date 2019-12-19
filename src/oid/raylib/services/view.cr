class RayLib::ViewService
  include Oid::Service::View

  @[JSON::Field(ignore: true)]
  getter textures : Hash(String, RayLib::Texture2D) = Hash(String, RayLib::Texture2D).new
  @[JSON::Field(ignore: true)]
  getter texture_links : Hash(String, Entitas::UnsafeAERC) = Hash(String, Entitas::UnsafeAERC).new

  def init_controller(contexts : Contexts, entity : Oid::RenderableEntity) : Oid::Controller::View
    RayLib::ViewController.new(contexts, entity)
  end

  def load_texture(path, name, entity)
    # Texture already exists
    if textures[name]?
      # Retain it
      texture_links[name].retain(entity)
    else
      # Need to load it
      textures[name] = RayLib.load_texture(
        File.join(path, name)
      )

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
end