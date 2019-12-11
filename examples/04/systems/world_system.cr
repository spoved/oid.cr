class Example::WorldSystem
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem

  protected property contexts : Contexts
  protected property actors : Entitas::Group(GameEntity)

  def initialize(@contexts)
    @actors = @contexts.game.get_group(GameMatcher.all_of(GameMatcher.actor))
  end

  def init
    config_service = contexts.meta.config_service.instance

    # ////////////////////////////////////////////////////
    # TODO: Initialize your world here!
    # ////////////////////////////////////////////////////

    # Create player
    player = contexts.game
      .create_entity
      .add_actor(name: "player")
      .add_position(Oid::Vector3.zero)

    # Create camera
    camera = contexts.game.create_entity
      .add_camera(

        value: Oid::Camera2D.new(
          target: player.actor,
          offset: Oid::Vector2.zero,
        )
      )
  end

  def execute
    actors.each do |entity|
      entity = entity.as(GameEntity)

      # ////////////////////////////////////////////////////
      # TODO: Add game logic!
      # ////////////////////////////////////////////////////
    end
  end
end
