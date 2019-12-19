class Example::WorldSystem
  include Oid::Services::Helper
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem

  protected property contexts : Contexts
  protected property actors : Entitas::Group(StageEntity)
  protected property zoom_out : Bool = false

  def initialize(@contexts)
    @actors = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.actor))
  end

  def context
    contexts.stage
  end

  def init
    # ////////////////////////////////////////////////////
    # TODO: Initialize your world here!
    # ////////////////////////////////////////////////////

    # Create player
    player = create_player

    outline = create_outline
    player.add_child(outline)

    label = create_label
    outline.add_child(label)

    # Create Block1
    # context.create_entity
    #   .add_actor(name: "block01")
    #   .add_position(Oid::Vector3.new(0.0, 0.0, 0.0))
    #   .add_view_element(
    #     value: Oid::Element::Rectangle.new(
    #       width: 128.0,
    #       height: 110.0,
    #       color: Oid::Color::RED
    #     ),
    #     origin: Oid::Enum::OriginType::Center
    #   )
    # .add_asset(
    #   name: "Blocker.png",
    #   type: Oid::Enum::AssetType::Texture,
    #   origin: Oid::Enum::OriginType::Center
    # )

    # context.create_entity
    # .add_prop(name: "text_01")
    # .add_position(Oid::Vector3.new(0.0, -100.0, 100.0))
    # .add_view_element(value: Oid::Element::Text.new(
    #   text: "Hello World",
    #   font_size: 20,
    #   color: Oid::Color::BLUE
    # ))

    generate_origin_grid
    generate_2d_grid(1000, 20.0)
  end

  def execute
    actors.each do |entity|
      entity = entity.as(StageEntity)
      if entity.actor? && entity.actor.name == "player"
        # Rotate
        # entity.rotate_x(1.0)

        # Zoom
        # scale(entity)

        # Random move
        random_move(entity)
      end
    end
  end

  def create_player
    context.create_entity
      .add_actor(name: "player")
      .add_camera_target
      .add_position(Oid::Vector3.new(20.0, 20.0, 10.0))
      .add_position_type(Oid::Enum::Position::Relative)
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

  def create_label
    context.create_entity
      .add_prop(name: "player_label")
      .add_position(Oid::Vector3.new(2.5 - (68.0/2), 0.0, 10.0))
      .add_position_type(Oid::Enum::Position::Relative)
      .add_view_element(
        value: Oid::Element::Text.new(
          text: "player",
          font_size: 20,
          color: Oid::Color::BLACK
        ),
        origin: Oid::Enum::OriginType::UpperLeft
      )
      .add_scale(1.0)
  end

  def create_outline
    context.create_entity
      .add_position(Oid::Vector3.new(0.0, 10.0, 10.0))
      .add_position_type(Oid::Enum::Position::Relative)
      .add_view_element(
        value: Oid::Element::Rectangle.new(
          width: 68.0,
          height: 20.0,
          color: Oid::Color::GOLD
        ),
        origin: Oid::Enum::OriginType::UpperCenter
      )
      .add_scale(1.0)
  end

  def generate_origin_grid
    # Create X/Y Lines
    context.create_entity
      .add_actor(name: "line_x")
      .add_position(Oid::Vector3.new(x: -2000.0, y: 0.0, z: 100.0))
      .add_view_element(
        value: Oid::Element::Line.new(
          end_pos: Oid::Vector2.new(x: 2000.0, y: 0.0),
          color: Oid::Color::GREEN,
        ),
        origin: Oid::Enum::OriginType::UpperCenter,
      )
    context.create_entity
      .add_actor(name: "line_y")
      .add_position(Oid::Vector3.new(x: 0.0, y: -2000.0, z: 100.0))
      .add_view_element(
        value: Oid::Element::Line.new(
          end_pos: Oid::Vector2.new(x: 0.0, y: 2000.0),
          color: Oid::Color::GREEN,
        ),
        origin: Oid::Enum::OriginType::UpperCenter,
      )
  end

  def generate_2d_grid(size, spacing)
    grid = Oid::Element::Grid.new(size: size, spacing: spacing)
    z = -100.0
    (grid.size/grid.spacing).to_i.times do |i|
      # Make X Positive
      make_grid_x_entity(2000.0, (i*grid.spacing), z)
      # Make X Negative
      make_grid_x_entity(2000.0, -(i*grid.spacing), z)

      # Make Y Positive
      make_grid_y_entity((i*grid.spacing), 2000.0, z)
      # Make Y Negative
      make_grid_y_entity(-(i*grid.spacing), -2000.0, z)
    end
  end

  private def make_grid_y_entity(x, y, z)
    context.create_entity
      .add_position(Oid::Vector3.new(x: x, y: -y, z: z))
      .add_view_element(
        value: Oid::Element::Line.new(
          end_pos: Oid::Vector2.new(x: x, y: y),
          color: Oid::Color::GRAY,
        ),
        origin: Oid::Enum::OriginType::UpperCenter,
      )
  end

  private def make_grid_x_entity(x, y, z)
    context.create_entity
      .add_position(Oid::Vector3.new(x: -x, y: y, z: z))
      .add_view_element(
        value: Oid::Element::Line.new(
          end_pos: Oid::Vector2.new(x: x, y: y),
          color: Oid::Color::GRAY,
        ),
        origin: Oid::Enum::OriginType::UpperCenter,
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
