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
    if entity.asset?
      unload_asset
    end
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

    if e.view_element?
      draw_element(e)
    end

    if e.asset?
      draw_asset(e)
    end
  end

  private def draw_element(e : Oid::RenderableEntity)
    position = e.transform
    object = e.view_element.value
    rotation = e.rotation.value
    scale = e.scale.value.to_f32

    case object
    when Oid::Element::Rectangle
      rectangle = RayLib::Rectangle.new(
        x: position.x.to_f32,
        y: position.y.to_f32,
        width: object.width.to_f32 * scale,
        height: object.height.to_f32 * scale,
      )
      origin = calc_origin(e.view_element.origin, width: rectangle.width, height: rectangle.height)

      RayLib.draw_rectangle_pro(
        rec: rectangle,
        origin: origin,
        rotation: rotation.magnitude.to_f32,
        color: object.color.to_unsafe,
      )
    when Oid::Element::Line
      RayLib.draw_line(
        start_pos_x: position.x.to_i,
        start_pos_y: position.y.to_i,
        end_pos_x: object.end_pos.x.to_i,
        end_pos_y: object.end_pos.y.to_i,
        color: object.color.to_unsafe,
      )
    when Oid::Element::Cube
      RayLib.draw_cube(
        position: RayLib::Vector3.new(position),
        width: object.size.x.to_f32 * scale,
        height: object.size.y.to_f32 * scale,
        length: object.size.z.to_f32 * scale,
        color: object.color.to_unsafe,
      )
    when Oid::Element::CubeWires
      RayLib.draw_cube_wires(
        position: RayLib::Vector3.new(position),
        width: object.size.x.to_f32 * scale,
        height: object.size.y.to_f32 * scale,
        length: object.size.z.to_f32 * scale,
        color: object.color.to_unsafe,
      )
    when Oid::Element::Grid
      RayLib.draw_grid(
        slices: object.size,
        spacing: object.spacing.to_f32,
      )
    when Oid::Element::Text
      RayLib.draw_text(
        text: object.text,
        pos_x: position.x.to_i,
        pos_y: position.y.to_i,
        font_size: (object.font_size * scale).to_i,
        color: object.color.to_unsafe,
      )
    end
  end

  private def draw_asset(e : Oid::RenderableEntity)
    case e.asset.type
    when Oid::Enum::AssetType::Texture
      draw_texture(e)
    end
  end

  private def draw_texture(e : Oid::RenderableEntity)
    position = e.transform
    texture = view_service.textures[e.asset.name]
    scale = e.scale.value.to_f32
    source_rec = RayLib::Rectangle.new(
      x: 0.0f32,
      y: 0.0f32,
      height: texture.height.to_f32,
      width: texture.width.to_f32,
    )
    dest_rec = RayLib::Rectangle.new(
      x: position.x.to_f32,
      y: position.y.to_f32,
      height: source_rec.height * scale,
      width: source_rec.width * scale,
    )
    origin = calc_origin(e.asset.origin, width: dest_rec.width, height: dest_rec.height)

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

  private def calc_origin(origin_type : Oid::Enum::OriginType, width : Float32, height : Float32) : RayLib::Vector2
    case origin_type
    when Oid::Enum::OriginType::UpperLeft
      RayLib::Vector2.new(
        x: 0.0f32,
        y: 0.0f32,
      )
    when Oid::Enum::OriginType::UpperCenter
      RayLib::Vector2.new(
        x: width/2,
        y: 0.0f32,
      )
    when Oid::Enum::OriginType::UpperRight
      RayLib::Vector2.new(
        x: width,
        y: 0.0f32,
      )
    when Oid::Enum::OriginType::CenterLeft
      RayLib::Vector2.new(
        x: 0.0f32,
        y: height/2,
      )
    when Oid::Enum::OriginType::Center
      RayLib::Vector2.new(
        x: width/2,
        y: height/2,
      )
    when Oid::Enum::OriginType::CenterRight
      RayLib::Vector2.new(
        x: width,
        y: height/2,
      )
    when Oid::Enum::OriginType::BottomLeft
      RayLib::Vector2.new(
        x: 0.0f32,
        y: height,
      )
    when Oid::Enum::OriginType::BottomCenter
      RayLib::Vector2.new(
        x: width/2,
        y: height,
      )
    when Oid::Enum::OriginType::BottomRight
      RayLib::Vector2.new(
        x: width,
        y: height,
      )
    else
      RayLib::Vector2.new(
        x: 0.0f32,
        y: 0.0f32,
      )
    end
  end
end
