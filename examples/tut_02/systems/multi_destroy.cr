require "../components"

module IDistroyableEntity
  include Entitas::IEntity
  include Destroyed::Helper
end

class GameEntity < Entitas::Entity
  include IDistroyableEntity
end

class InputEntity < Entitas::Entity
  include IDistroyableEntity
end

class UiEntity < Entitas::Entity
  include IDistroyableEntity
end

class MultiDestroySystem < Entitas::MultiReactiveSystem
  spoved_logger

  def get_trigger(contexts : ::Contexts) : Array(Entitas::ICollector)
    [
      contexts.game.create_collector(GameMatcher.destroyed),
      contexts.input.create_collector(InputMatcher.destroyed),
      contexts.ui.create_collector(InputMatcher.destroyed),
    ] of Entitas::ICollector
  end

  def filter(entity : IDistroyableEntity)
    entity.has_destroyed?
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      logger.debug("Destroyed Entity from #{e.context_info.name} context")
      e.destroy
    end
  end
end
