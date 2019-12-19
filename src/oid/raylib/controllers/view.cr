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
      texture = view_service.textures[e.asset.name]
      scale = e.scale.value.to_f32
      source_rec = RayLib::Rectangle.new(
        x: 0.0f32,
        y: 0.0f32,
        height: texture.height.to_f32,
        width: texture.width.to_f32,
      )
      dest_rec = RayLib::Rectangle.new(
        x: e.position.value.x.to_f32,
        y: e.position.value.y.to_f32,
        height: source_rec.height * scale,
        width: source_rec.width * scale,
      )
      origin = calc_asset_origin(e.asset.origin, dest_rec.height, dest_rec.width)

      RayLib.draw_texture_pro(
        texture: texture,
        # Rectangle on texture
        source_rec: source_rec,
        # Rectangle in the world
        dest_rec: dest_rec,
        # Origin in relation to dest rectangle
        origin: origin,

        rotation: e.rotation.value.magnitude.to_f32,
        # scale: e.scale.value.to_f32,
        tint: Oid::Color::WHITE.to_unsafe
      )
    end
  end

  private def calc_asset_origin(origin_type : Oid::Enum::OriginType, width : Float32, height : Float32) : RayLib::Vector2
    case origin_type
    when Oid::Enum::OriginType::UpperLeft
      RayLib::Vector2.new(
        x: 0.0f32,
        y: 0.0f32,
      )
    when Oid::Enum::OriginType::UpperCenter
      RayLib::Vector2.new(
        x: 0.0f32,
        y: width/2,
      )
    when Oid::Enum::OriginType::UpperRight
      RayLib::Vector2.new(
        x: 0.0f32,
        y: width,
      )
    when Oid::Enum::OriginType::CenterLeft
      RayLib::Vector2.new(
        x: height/2,
        y: 0.0f32,
      )
    when Oid::Enum::OriginType::Center
      RayLib::Vector2.new(
        x: height/2,
        y: width/2,
      )
    when Oid::Enum::OriginType::CenterRight
      RayLib::Vector2.new(
        x: height,
        y: width/2,
      )
    when Oid::Enum::OriginType::BottomLeft
      RayLib::Vector2.new(
        x: height,
        y: 0.0f32,
      )
    when Oid::Enum::OriginType::BottomCenter
      RayLib::Vector2.new(
        x: height,
        y: width/2,
      )
    when Oid::Enum::OriginType::BottomRight
      RayLib::Vector2.new(
        x: height,
        y: width,
      )
    else
      RayLib::Vector2.new(
        x: 0.0f32,
        y: 0.0f32,
      )
    end
  end
end
