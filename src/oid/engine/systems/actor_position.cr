module Oid
  module Systems
    class ActorPosition < Entitas::ReactiveSystem
      def self.new(contexts : Contexts)
        ActorPosition.new(contexts.game)
      end

      def get_trigger(context : Entitas::Context) : Entitas::ICollector
        context.create_collector(GameMatcher.position)
      end

      # Select entities with position and is an actor
      def filter(entity : GameEntity)
        puts entity
        entity.position? && entity.actor?
      end

      def execute(entities : Array(Entitas::IEntity))
        entities.each do |e|
          e = e.as(GameEntity)
          e.actor.position = e.position.value
        end
      end
    end
  end
end
