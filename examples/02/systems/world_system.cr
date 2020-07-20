class Example::WorldSystem
  spoved_logger

  include Example::Helper
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem

  protected property contexts : Contexts
  protected property actors : Entitas::Group(StageEntity)

  def initialize(@contexts)
    @actors = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.actor))
  end

  def context
    contexts.stage
  end

  def init
    # Create player
    player = create_player(
      position: Oid::Vector3.new(0.0, 0.0, 100.0),
      origin: Oid::Enum::OriginType::Center,
    )
    player.add_movable.add_player
    # player.add_child(
    #   generate_origin_grid("player_target", Oid::Color::RED)
    # )
    player.replace_view_element(
      value: Oid::Element::Rectangle.new(
        width: 40.0,
        height: 40.0,
        color: Oid::Color::RED
      ),
      origin: Oid::Enum::OriginType::Center
    )

    # Add ground
    contexts.stage
      .create_entity
      .add_actor(name: "ground")
      .add_position(value: Oid::Vector3.new(0, 320, 0))
      .add_view_element(
        value: Oid::Element::Rectangle.new(
          width: 13000.0, height: 8000.0, color: Oid::Color::GRAY
        ),
        origin: Oid::Enum::OriginType::UpperCenter
      )

    # Create "Buildings"
    spacing = 0
    100.times do |i|
      b_rec = Oid::Element::Rectangle.new(
        width: Random.rand(50..200).to_f,
        height: Random.rand(100..800).to_f,
        color: Oid::Color.new(
          Random.rand(200_u8..240_u8),
          Random.rand(200_u8..240_u8),
          Random.rand(200_u8..240_u8),
        )
      )

      contexts.stage
        .create_entity
        .add_actor(name: "building_#{i}")
        .add_position(
          Oid::Vector3.new(
            x: -6000 + spacing,
            y: 320 - b_rec.height,
            z: 10
          )
        )
        .add_view_element(
          value: b_rec,
          origin: Oid::Enum::OriginType::UpperRight
        )
      spacing += b_rec.width.to_i
    end
  end

  def execute
    actors.each do |entity|
      entity = entity.as(StageEntity)
      if entity.player?
        # puts "Player: #{entity}"
        # puts "Player: #{entity.actor.position.to_json}"
        # puts "Camera: #{contexts.stage.camera.value}"
        # puts "Camera: #{contexts.stage.camera.value.target.position.to_json}"
      end
    end
  end
end
