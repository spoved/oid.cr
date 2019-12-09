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
  end

  def execute
  end
end
