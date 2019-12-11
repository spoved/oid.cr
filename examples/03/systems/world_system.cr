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

    origin = contexts.game
      .create_entity
      .add_actor(name: "origin")
      .add_position(Oid::Vector3.zero)
      .add_view

    # Add Grid
    origin.actor.add_object(
      Oid::Grid.new(
        size: 10,
        spacing: 1.0,
      ),
    )

    # Create cube
    cube = contexts.game
      .create_entity
      .add_actor(name: "cube")
      .add_position(Oid::Vector3.new(0.0, 1.0, 0.0))
      .add_view
      .add_interactive
    cube.actor.add_object(
      Oid::Cube.new(
        size: Oid::Vector3.new(2.0, 2.0, 2.0),
        color: Oid::Color::GRAY,
      ),
      position: Oid::Vector3.zero,
      rotation: Oid::Vector3.zero,
    )

    cube.actor.add_object(
      Oid::CubeWires.new(
        size: Oid::Vector3.new(2.0, 2.0, 2.0),
        color: Oid::Color::DARKGRAY,
      ),
      position: Oid::Vector3.zero,
      rotation: Oid::Vector3.zero,
    )

    # Create camera
    camera = contexts.game.create_entity
      .add_camera(
        Oid::Camera3D.new(
          position: Oid::Vector3.new(10.0, 10.0, 10.0),
          target: origin.actor,
          rotation: Oid::Vector3.up,
          fov_y: 45.0,
          type: Oid::Camera::Type::Perspective
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
