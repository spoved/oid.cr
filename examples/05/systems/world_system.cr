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

    # Create player
    player = create_player

    outline = create_outline
    player.add_child(outline)

    label = create_label
    outline.add_child(label)

    player.add_child(generate_origin_grid("player_target", Oid::Color::RED))

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

    generate_2d_grid(1000, 20.0)
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
          random_move(entity)
        when "grid_2d"
          # entity.destroyed = true
        else
        end
      end
    end
  end
end
