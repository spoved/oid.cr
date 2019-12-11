class Example::CollisionSystem < Entitas::ReactiveSystem
  protected property contexts : Contexts
  protected property context : InputContext
  protected property game_actors : Entitas::Group(GameEntity)

  def initialize(@contexts)
    @context = @contexts.input
    @collector = get_trigger(@context)
    @game_actors = @contexts.game.get_group(GameMatcher.all_of(GameMatcher.actor, GameMatcher.interactive))
  end

  def filter(entity : InputEntity)
    entity.input?
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(InputMatcher.input)
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |entity|
      entity = entity.as(InputEntity)

      # TODO: Check collision
      puts entity.input.position

      entity.destroyed = true
    end
  end
end
