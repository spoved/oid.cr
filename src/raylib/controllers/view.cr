class RayLib::ViewController
  include Oid::Controller::View
  include Oid::Components::Destroyed::Listener
  include Oid::Services::Helper

  private getter contexts : Contexts
  private getter entity : Oid::RenderableEntity

  def initialize(@contexts, @entity)
    # puts "initialize view controller for #{@entity}"
    init_view(@contexts, @entity)
    # puts "asset loaded: #{@entity.asset_loaded?} #{@entity}"
  end

  def init_view(contexts : Contexts, entity)
    register_listeners(entity)

    if entity.asset?
      load_asset
    end

    self
  end

  def destroy_view
    if entity.asset?
      unload_asset
    end
  end

  def bounding_box : Oid::Element::BoundingBox
    if entity.view_element?
      Oid::CollisionFuncs.bounding_box_for_element(entity)
    elsif entity.has_asset?
      # texture = view_service.textures[entity.asset.name]
      # Oid::CollisionFuncs.bounding_box_for_asset(entity, texture.width, texture.height)

      case entity.asset.type
      when Oid::Enum::AssetType::Texture
        texture = view_service.texture(entity.asset.name)
        raise "No texture found for #{entity.asset.name}" if texture.nil?
        Oid::CollisionFuncs.bounding_box_for_asset(entity, texture.width, texture.height)
      when Oid::Enum::AssetType::SubTexture
        texture, _ = view_service.sub_texture(entity.asset.name)
        raise "No sub texture found for #{entity.asset.name}" if texture.nil?
        Oid::CollisionFuncs.bounding_box_for_asset(entity, texture.width, texture.height)
      else
        raise "Unable to draw bounding box for asset type: #{entity.asset.type}"
      end
    else
      raise "Cannot calculate bounding box for #{entity.to_s}"
    end
  end

  def register_listeners(e : Entitas::IEntity)
    e.add_destroyed_listener(self)
  end

  def on_destroyed(e, component : Oid::Components::Destroyed)
    self.destroy_view
  end

  def try_load_asset
    return if entity.asset_loaded?
    load_asset
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
    when Oid::Enum::AssetType::TextureAtlas
      unless view_service.textures[asset_name]?
        logger_service.log("Loading #{entity.asset.type} => #{asset_name}")
        view_service.load_texture_atlas(config_service.asset_path, asset_name, entity)
      end
    when Oid::Enum::AssetType::SubTexture
      logger_service.log("Loading #{entity.asset.type} => #{asset_name}")
      # Check to see if the sub texture exists yet
      text, _ = view_service.sub_texture(asset_name)
      if text.nil?
        logger_service.log("Subtexture #{entity.asset.type} => #{asset_name} is not loaded yet")
        entity.asset_loaded = false
        return
      end
    else
      logger_service.log("Unsupported asset type #{entity.asset.type}", ::Log::Severity::Error)
      return
    end

    entity.asset_loaded = true
  end

  private def unload_asset
    case entity.asset.type
    when Oid::Enum::AssetType::Texture, Oid::Enum::AssetType::TextureAtlas
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
    scale = e.rel_scale.to_f32

    case object
    when Oid::Element::Rectangle
      rectangle = RayLib::Rectangle.new(
        x: position.x.to_f32,
        y: position.y.to_f32,
        width: object.width.to_f32 * scale,
        height: object.height.to_f32 * scale,
      )

      origin = RayLib::Vector2.new(Oid::CollisionFuncs.calc_rec_origin(
        e.view_element.origin,
        width: rectangle.width,
        height: rectangle.height,
      ))

      RayLib.draw_rectangle_pro(
        rec: rectangle,
        origin: origin,
        rotation: rotation.magnitude.to_f32,
        color: object.color.to_unsafe,
      )
    when Oid::Element::Line
      end_pos = e.transform_position_rel_to(e.transform_origin, Oid::Vector3.new(
        x: object.end_pos.x,
        y: object.end_pos.y,
        z: e.position.value.z,
      ))

      RayLib.draw_line_ex(
        start_pos: RayLib::Vector2.new(position.to_v2),
        end_pos: RayLib::Vector2.new(end_pos.to_v2),
        thick: object.thickness.to_f32 * scale,
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
      draw_text(e, object, position, rotation, scale)
    end
  end

  private def draw_text(e : Oid::RenderableEntity, object, position, rotation, scale)
    font_size = (object.font_size * scale).to_i
    text_width = RayLib.measure_text(object.text, font_size)

    origin = Oid::CollisionFuncs.calc_rec_origin(
      e.view_element.origin,
      width: text_width,
      height: font_size,
    ).to_v3
    pos = position - origin

    RayLib.draw_text(
      text: object.text,
      pos_x: pos.x.to_i,
      pos_y: pos.y.to_i,
      font_size: font_size,
      color: object.color.to_unsafe,
    )
  end

  private def draw_asset(e : Oid::RenderableEntity)
    case e.asset.type
    when Oid::Enum::AssetType::Texture
      draw_texture(e)
    when Oid::Enum::AssetType::SubTexture
      draw_sub_texture(e)
    end
  end

  # Draw a sub texture from an atlas
  private def draw_sub_texture(e : Oid::RenderableEntity)
    texture, info = view_service.sub_texture(e.asset.name)
    if texture.nil?
      e.asset_loaded = false
      logger_service.log("No sub texture found for #{e.asset.name}", ::Log::Severity::Warn)
      return
    end

    return if info.nil?

    scale = e.scale.value.to_f32

    # TODO: Handle padding...

    source_rec = RayLib::Rectangle.new(
      x: info[:pos_x],
      y: info[:pos_y],
      height: info[:height],
      width: info[:width],
    )

    position = e.transform

    dest_rec = RayLib::Rectangle.new(
      x: position.x.to_f32,
      y: position.y.to_f32,
      height: source_rec.height * scale,
      width: source_rec.width * scale,
    )
    origin = RayLib::Vector2.new(Oid::CollisionFuncs.calc_rec_origin(
      e.asset.origin,
      width: dest_rec.width,
      height: dest_rec.height
    ))

    RayLib.draw_texture_pro(
      texture: texture,
      # Rectangle on texture
      source: source_rec,
      # Rectangle in the world
      dest: dest_rec,
      # Origin in relation to dest rectangle
      origin: origin,

      rotation: e.rotation.value.magnitude.to_f32,
      # scale: e.scale.value.to_f32,
      tint: Oid::Color::WHITE.to_unsafe
    )
  end

  private def draw_texture(e : Oid::RenderableEntity)
    position = e.transform

    texture = view_service.texture(e.asset.name)
    if texture.nil?
      e.asset_loaded = false
      load_asset
      texture = view_service.textures[e.asset.name]
    end
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
    origin = RayLib::Vector2.new(Oid::CollisionFuncs.calc_rec_origin(
      e.asset.origin,
      width: dest_rec.width,
      height: dest_rec.height
    ))

    RayLib.draw_texture_pro(
      texture: texture,
      # Rectangle on texture
      source: source_rec,
      # Rectangle in the world
      dest: dest_rec,
      # Origin in relation to dest rectangle
      origin: origin,

      rotation: e.rotation.value.magnitude.to_f32,
      # scale: e.scale.value.to_f32,
      tint: Oid::Color::WHITE.to_unsafe
    )
  end
end
