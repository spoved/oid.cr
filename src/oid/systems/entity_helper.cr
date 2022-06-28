module Oid::Systems::EntityHelper
  abstract def context

  def mark_real_origin(color = Oid::Color::RED)
    context.create_entity
      .add_position(Oid::Vector3.new(0.0, 0.0, 0.0))
      .add_position_type(Oid::Enum::Position::Static)
      .add_child(generate_origin_grid("real_origin", color, 100.0))
  end

  def make_dot(position, size = 3.0, color = Oid::Color::BLACK,
               origin = Oid::Enum::OriginType::Center,
               pos_type = Oid::Enum::Position::Static)
    context.create_entity
      .add_position(position)
      .add_position_type(pos_type)
      .add_view_element(
        value: Oid::Element::Rectangle.new(
          width: size,
          height: size,
          color: color
        ),
        origin: origin,
      )
      .add_scale(1.0)
  end

  def create_label(name, text,
                   position = Oid::Vector3.new(2.5 - (68.0/2), 0.0, 10.0),
                   origin = Oid::Enum::OriginType::UpperLeft,
                   font_size = 20,
                   color = Oid::Color::BLACK,
                   position_type = Oid::Enum::Position::Relative)
    context.create_entity
      .add_prop(name: name)
      .add_position(position)
      .add_position_type(position_type)
      .add_view_element(
        value: Oid::Element::Text.new(
          text: text,
          font_size: font_size,
          color: color,
        ),
        origin: origin,
      )
      .add_scale(1.0)
  end

  def create_rec(position = Oid::Vector3.new(0.0, 10.0, 10.0),
                 width = 68.0, height = 20.0, color = Oid::Color::GOLD,
                 origin = Oid::Enum::OriginType::UpperCenter, pos_type = Oid::Enum::Position::Relative)
    context.create_entity
      .add_position(position)
      .add_position_type(pos_type)
      .add_view_element(
        value: Oid::Element::Rectangle.new(
          width: width,
          height: height,
          color: color,
        ),
        origin: origin
      )
      .add_scale(1.0)
  end

  # Draw a line
  def create_line(start_pos : Oid::Vector3, end_pos : Oid::Vector2, thickness = 1.0, color = Oid::Color::GRAY)
    line = context.create_entity
      .add_position(start_pos)
      .add_view_element(
        value: Oid::Element::Line.new(
          end_pos: end_pos,
          color: color,
          thickness: thickness,
        ),
        origin: Oid::Enum::OriginType::UpperLeft,
      )
    line
  end

  # Draw a rectangle outline
  def create_outline(position = Oid::Vector3.new(0.0, 10.0, 10.0),
                     width = 68.0, height = 20.0, thickness = 1.0,
                     color = Oid::Color::GOLD,
                     origin = Oid::Enum::OriginType::UpperCenter, pos_type = Oid::Enum::Position::Relative)
    outline = context.create_entity
      .add_position(position)
      .add_position_type(pos_type)

    # Draw top
    outline.add_child create_line(
      Oid::Vector3.new(0.0, 0.0, 0.0),
      Oid::Vector2.new(width, 0.0),
      thickness,
      color
    )
    # Draw bottom
    outline.add_child create_line(
      Oid::Vector3.new(0.0, height, 0.0),
      Oid::Vector2.new(width, height),
      thickness,
      color
    )
    # Draw left
    outline.add_child create_line(
      Oid::Vector3.new(0.0, 0.0, 0.0),
      Oid::Vector2.new(0.0, height),
      thickness,
      color
    )
    # Draw right
    outline.add_child create_line(
      Oid::Vector3.new(width, 0.0, 0.0),
      Oid::Vector2.new(width, height),
      thickness,
      color
    )

    outline
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

  # Generate a 2D grid
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
end
