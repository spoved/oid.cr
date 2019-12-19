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
    context.create_entity
      .add_camera
      .add_position(Oid::Vector3.zero)

    # context.create_entity
    #   .add_actor(name: "player")
    #   .add_camera_target
    #   .add_position(Oid::Vector3.new(400.0, 300.0, 0.0))
    #   .add_asset(
    #     name: "Blocker.png",
    #     type: Oid::Enum::AssetType::Texture,
    #     origin: Oid::Enum::OriginType::Center
    #   )
    #   .add_view_element(
    #     value: Oid::Element::Rectangle.new(
    #       width: 128.0,
    #       height: 110.0,
    #       color: Oid::Color::BLUE
    #     ),
    #     origin: Oid::Enum::OriginType::Center
    #   )

    context.create_entity
      .add_actor(name: "block01")
      .add_position(Oid::Vector3.new(400.0, 300.0, 0.0))
      .add_view_element(
        value: Oid::Element::Rectangle.new(
          width: 128.0,
          height: 110.0,
          color: Oid::Color::RED
        ),
        origin: Oid::Enum::OriginType::BottomRight
      )

    context.create_entity
      .add_actor(name: "line_x")
      .add_position(Oid::Vector3.new(x: 0.0, y: 300.0, z: 0.0))
      .add_view_element(
        value: Oid::Element::Line.new(
          end_pos: Oid::Vector2.new(x: 800.0, y: 300.0),
          color: Oid::Color::GREEN,
        ),
        origin: Oid::Enum::OriginType::UpperCenter,
      )

    context.create_entity
      .add_actor(name: "line_y")
      .add_position(Oid::Vector3.new(x: 400.0, y: 0.0, z: 0.0))
      .add_view_element(
        value: Oid::Element::Line.new(
          end_pos: Oid::Vector2.new(x: 400.0, y: 600.0),
          color: Oid::Color::GREEN,
        ),
        origin: Oid::Enum::OriginType::UpperCenter,
      )
  end

  def random_move(entity)
    unless entity.move?
      entity.add_move(target: Oid::Vector3.new(
        x: Random.rand(0.0...800.0),
        y: Random.rand(0.0...600.0),
        z: 0.0
      ))
    end
  end

  def zoom(entity)
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

  def execute
    actors.each do |entity|
      entity = entity.as(StageEntity)
      if entity.actor? && entity.actor.name == "player"
        # Rotate
        # entity.replace_rotation(entity.rotation.rotate_x(1.0))

        # Zoom
        # zoom(entity)

        # Random move
        # random_move(entity)
      end
    end
  end
end
