class RayLib::ViewController
  include Oid::Controller::View
  include Oid::Destroyed::Listener
  include Oid::Services::Helper

  private getter contexts : Contexts
  private getter entity : Oid::RenderableEntity

  def initialize(@contexts, @entity)
    init_view(@contexts, @entity)
  end

  def init_view(c : Contexts, e : Oid::RenderableEntity)
    register_listeners(e)

    if e.asset?
      load_asset
    end

    self
  end

  def destroy_view
    unload_asset
  end

  def register_listeners(e : Entitas::IEntity)
    e.add_destroyed_listener(self)
  end

  def on_destroyed(e, component : Oid::Destroyed)
    self.destroy_view
  end

  private def load_asset
    # TODO: Check for asset loaded?
    asset_name = entity.asset.name

    case entity.asset.type
    when Oid::Enum::AssetType::Texture
      unless view_service.textures[asset_name]?
        logger_service.log("Loading #{entity.asset.type} => #{asset_name}")
        view_service.load_texture(config_service.asset_path, asset_name, entity)
      end
    else
      logger_service.log("Unsupported asset type #{entity.asset.type}")
      return
    end
    entity.asset_loaded = true
  end

  private def unload_asset
    case entity.asset.type
    when Oid::Enum::AssetType::Texture
      view_service.unload_texture(entity.asset.name, entity)
    else
      logger_service.log("Unsupported asset type #{entity.asset.type}")
      return
    end
    entity.asset_loaded = false
  end

  def draw
    e = entity.as(Oid::RenderableEntity)
    case e.asset.type
    when Oid::Enum::AssetType::Texture
      RayLib.draw_texture_ex(
        texture: view_service.textures[e.asset.name],
        position: RayLib::Vector2.new(
          e.position.value.x.to_f32,
          e.position.value.y.to_f32,
        ),
        rotation: e.rotation.value.magnitude.to_f32,
        scale: e.scale.value.to_f32,
        tint: Oid::Color::WHITE.to_unsafe
      )
    end
  end
end
