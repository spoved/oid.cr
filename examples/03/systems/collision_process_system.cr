class Example::CollisionProcessSystem < Entitas::ReactiveSystem
  include Example::Helper
  include Oid::Services::Helper
  include Oid::CollisionFuncs

  protected property contexts : Contexts
  protected property context : StageContext

  def initialize(@contexts)
    @context = @contexts.stage
    @collector = get_trigger(@context)
  end

  def filter(entity : StageEntity)
    entity.collision?
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(StageMatcher.all_of(
      StageMatcher.collision,
    ))
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |entity|
      if entity.is_a?(StageEntity)
        target = entity.collision.target.as(StageEntity)
        target.selected = !target.selected?
        entity.destroyed = true
      end
    end
  end
end
