class WorldSystem
  spoved_logger

  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem

  protected property contexts : Contexts
  protected property actors : Entitas::Group(GameEntity)

  def initialize(@contexts)
    @actors = @contexts.game.get_group(GameMatcher.all_of(GameMatcher.actor))
  end

  def init
    config_service = contexts.meta.config_service.instance

    # Create player
    player = contexts.game
      .create_entity
      .add_player
      .add_actor(name: "player")
      .add_position(value: Oid::Vector3.new(400, 300, 100))
      .add_movable
      .add_view

    # Add square to actor
    player.actor.add_object(
      Oid::Rectangle.new(width: 40.0, height: 40.0, color: Oid::Color::RED),
      position: Oid::Vector3.new(-20.0, -20.0, 0.0),
      rotation: Oid::Vector3.new(0, 0, 0)
    )

    # Create camera
    camera = contexts.game.create_entity
      .add_camera(
        value: Oid::Camera2D.new(
          target: player.actor,
          offset: Oid::Vector2.new(0.0, 0.0),
          mode: Oid::Camera::Mode::Free
        )
      )

    # Add ground
    contexts.game
      .create_entity
      .add_view
      .add_actor(name: "ground")
      .add_position(value: Oid::Vector3.new(-6000, 320, 0))
      .actor.add_object(
        Oid::Rectangle.new(
          width: 13000.0, height: 8000.0, color: Oid::Color::GRAY
        )
      )

    # Add X line
    player.actor.add_object(
      Oid::Line.new(
        Oid::Vector2.new(
          x: (config_service.screen_w * 10) - player.position.value.x,
          y: (config_service.screen_h/2) - player.position.value.y,
        ),
        color: Oid::Color::GREEN
      ),
      position: Oid::Vector3.new(
        x: -(config_service.screen_w/2) * 10,
        y: 0.0,
        z: 0.0
      ),
    )
    # Add Y line
    player.actor.add_object(
      Oid::Line.new(
        Oid::Vector2.new(
          x: (config_service.screen_w/2) - player.position.value.x,
          y: (config_service.screen_h * 10) - player.position.value.y,
        ),
        color: Oid::Color::GREEN
      ),
      position: Oid::Vector3.new(
        x: 0.0,
        y: -(config_service.screen_h/2) * 10,
        z: 0.0
      ),
    )

    # Create "Buildings"
    spacing = 0
    100.times do |i|
      b_rec = Oid::Rectangle.new(
        width: Random.rand(50..200).to_f,
        height: Random.rand(100..800).to_f,
        color: Oid::Color.new(
          Random.rand(200_u8..240_u8),
          Random.rand(200_u8..240_u8),
          Random.rand(200_u8..240_u8),
        )
      )

      contexts.game
        .create_entity
        .add_actor(name: "building_#{i}")
        .add_position(
          Oid::Vector3.new(
            x: -6000 + spacing,
            y: 320 - b_rec.height,
            z: 10
          )
        )
        .add_view
        .actor.add_object(
          b_rec,
          position: Oid::Vector3.new(0.0, 0.0, 0.0),
          positioning: Oid::Enum::Position::Relative
        )

      spacing += b_rec.width.to_i
    end
  end

  def execute
    actors.each do |entity|
      entity = entity.as(GameEntity)
      if entity.player?
        # puts "Player: #{entity}"
        # puts "Player: #{entity.actor.position.to_json}"
        # puts "Camera: #{contexts.game.camera.value}"
        # puts "Camera: #{contexts.game.camera.value.target.position.to_json}"
      end
    end
  end
end
