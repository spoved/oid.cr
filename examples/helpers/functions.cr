module Example::Helper
  def create_player
    context.create_entity
      .add_actor(name: "player")
      .add_camera_target
      .add_position(Oid::Vector3.new(0.0, 0.0, 0.0))
      .add_position_type(Oid::Enum::Position::Static)
      .add_view_element(
        value: Oid::Element::Rectangle.new(
          width: 20.0,
          height: 20.0,
          color: Oid::Color::BLUE
        ),
        origin: Oid::Enum::OriginType::Center
      )
      .add_scale(1.0)
  end

  def make_dot(position, size = 3.0, color = Oid::Color::BLACK)
    context.create_entity
      .add_position(position)
      .add_position_type(Oid::Enum::Position::Static)
      .add_view_element(
        value: Oid::Element::Rectangle.new(
          width: size,
          height: size,
          color: color
        ),
        origin: Oid::Enum::OriginType::Center
      )
      .add_scale(1.0)
  end

  def create_label(name, text)
    context.create_entity
      .add_prop(name: name)
      .add_position(Oid::Vector3.new(2.5 - (68.0/2), 0.0, 10.0))
      .add_position_type(Oid::Enum::Position::Relative)
      .add_view_element(
        value: Oid::Element::Text.new(
          text: text,
          font_size: 20,
          color: Oid::Color::BLACK
        ),
        origin: Oid::Enum::OriginType::UpperLeft
      )
      .add_scale(1.0)
  end

  def create_outline(width = 68.0, height = 20.0, color = Oid::Color::GOLD)
    context.create_entity
      .add_position(Oid::Vector3.new(0.0, 10.0, 10.0))
      .add_position_type(Oid::Enum::Position::Relative)
      .add_view_element(
        value: Oid::Element::Rectangle.new(
          width: width,
          height: height,
          color: color
        ),
        origin: Oid::Enum::OriginType::UpperCenter
      )
      .add_scale(1.0)
  end

  def generate_origin_grid(name, color = Oid::Color::GREEN, length = 4000.0)
    # Create X/Y Lines
    x = context.create_entity
      .add_position(Oid::Vector3.new(x: -(length/2), y: 0.0, z: 1.0))
      .add_view_element(
        value: Oid::Element::Line.new(
          end_pos: Oid::Vector2.new(x: (length/2), y: 0.0),
          color: color,
        ),
        origin: Oid::Enum::OriginType::UpperCenter,
      )
    y = context.create_entity
      .add_position(Oid::Vector3.new(x: 0.0, y: -(length/2), z: 1.0))
      .add_view_element(
        value: Oid::Element::Line.new(
          end_pos: Oid::Vector2.new(x: 0.0, y: (length/2)),
          color: color,
        ),
        origin: Oid::Enum::OriginType::UpperCenter,
      )

    origin = context.create_entity
      .add_actor(name: name)
      .add_position(Oid::Vector3.zero)

    origin.add_child(x)
    origin.add_child(y)
    origin
  end

  def generate_2d_grid(size, spacing, length = 1600.0)
    origin = generate_origin_grid("grid_2d")
    length = length/2
    grid = Oid::Element::Grid.new(size: size, spacing: spacing)
    z = -100.0
    (grid.size/grid.spacing).to_i.times do |i|
      # Make X Positive
      origin.add_child make_grid_x_entity(length, (i*grid.spacing), z)
      # Make X Negative
      origin.add_child make_grid_x_entity(length, -(i*grid.spacing), z)

      # Make Y Positive
      origin.add_child make_grid_y_entity((i*grid.spacing), length, z)
      # Make Y Negative
      origin.add_child make_grid_y_entity(-(i*grid.spacing), -length, z)
    end

    origin
  end

  private def make_grid_y_entity(x, y, z)
    context.create_entity
      .add_position(Oid::Vector3.new(x: x, y: -y, z: z))
      # .add_position_type(Oid::Enum::Position::Static)
      .add_view_element(
        value: Oid::Element::Line.new(
          end_pos: Oid::Vector2.new(x: x, y: y),
          color: Oid::Color::GRAY,
        ),
      )
  end

  private def make_grid_x_entity(x, y, z)
    context.create_entity
      .add_position(Oid::Vector3.new(x: -x, y: y, z: z))
      # .add_position_type(Oid::Enum::Position::Static)
      .add_view_element(
        value: Oid::Element::Line.new(
          end_pos: Oid::Vector2.new(x: x, y: y),
          color: Oid::Color::GRAY,
        ),
      )
  end

  def random_move(entity)
    unless entity.move?
      entity.add_move(target: Oid::Vector3.new(
        x: Random.rand(-400.0...400.0),
        y: Random.rand(-300.0...300.0),
        z: entity.position.value.z,
      ))
    end
  end

  def scale(entity)
    if entity.scale.value <= 0.0
      self.zoom_out = true
    elsif entity.scale.value >= 1.0
      self.zoom_out = false
    end

    if zoom_out
      entity.replace_scale(entity.scale.value + 0.01)
    else
      entity.replace_scale(entity.scale.value - 0.01)
    end
  end
end
