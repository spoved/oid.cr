class Example::CollisionSystem < Entitas::ReactiveSystem
  protected property contexts : Contexts
  protected property context : GameContext

  def initialize(@contexts)
    @context = @contexts.game
    @collector = get_trigger(@context)
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(GameMatcher.collision)
  end

  def execute(entities : Array(Entitas::IEntity))
    view_service = contexts.meta.view_service.instance
    camera = contexts.game.camera.value

    entities.each do |entity|
      entity = entity.as(GameEntity)
      actor = entity.collision.target.as(GameEntity).actor

      # Change cube color
      cube = actor.get_child(Oid::Cube).first
      case cube.as(Oid::Cube).color
      when Oid::Color::GRAY
        cube.as(Oid::Cube).color = Oid::Color::RED
      when Oid::Color::RED
        cube.as(Oid::Cube).color = Oid::Color::GRAY
      end

      # Change wire color
      wire = actor.get_child(Oid::CubeWires).first.as(Oid::CubeWires)
      case wire.color
      when Oid::Color::MAROON
        wire.color = Oid::Color::DARKGRAY
      when Oid::Color::DARKGRAY
        wire.color = Oid::Color::MAROON
      end

      entity.destroyed = true
    end
  end
end
