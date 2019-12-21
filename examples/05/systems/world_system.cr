class Example::WorldSystem
  include Oid::Services::Helper
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem
  include Example::Helper

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
    generate_2d_grid(1000, 20.0)

    context.create_entity
      .add_position(Oid::Vector3.new(0.0, 0.0, 0.0))
      .add_position_type(Oid::Enum::Position::Static)
      .add_child(generate_origin_grid("real_origin", Oid::Color::RED, 100.0))

    # Create player
    # player = create_player

    # outline = create_outline
    # player.add_child(outline)

    # label = create_label
    # outline.add_child(label)

    # player.add_child(
    #   generate_origin_grid("player_target", Oid::Color::RED)
    # )

    text_box = contexts.stage.create_entity
      .add_actor("text_box")
      # .add_position(Oid::Vector3.new(20.0, 0.0, 0.0))
      .add_position(Oid::Vector3.zero)

      .add_position_type(Oid::Enum::Position::Static)
      .add_rotation
      .add_scale
      .add_view_element(
        value: Oid::Element::Rectangle.new(
          width: 20.0,
          height: 20.0,
          color: Oid::Color::GREEN
        ),
        origin: Oid::Enum::OriginType::UpperRight
      )

    box = Oid::CollisionFuncs.bounding_box_for_element(text_box)

    make_dot(box.min, color: Oid::Color::RED)
    make_dot(box.max, color: Oid::Color::RED)
  end

  def execute
    actors.each do |entity|
      entity = entity.as(StageEntity)
      if entity.actor?
        case entity.actor.name
        when "player"
          # Rotate
          # entity.rotate_x(1.0)

          # Zoom
          # scale(entity)

          # Random move
          # random_move(entity)
        when "grid_2d"
          # entity.destroyed = true
        else
        end
      end
    end
  end
end
