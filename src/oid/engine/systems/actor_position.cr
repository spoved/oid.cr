module Oid
  module Systems
    class ActorPosition < Entitas::ReactiveSystem
      spoved_logger

      protected property contexts : Contexts
      protected property context : GameContext

      def initialize(@contexts)
        @context = @contexts.game
        @collector = get_trigger(@context)
      end

      def get_trigger(context : Entitas::Context) : Entitas::ICollector
        context.create_collector(GameMatcher.position)
      end

      # Select entities with position and is an actor
      def filter(entity : GameEntity)
        entity.position? && entity.actor?
      end

      def execute(entities : Array(Entitas::IEntity))
        entities.each do |e|
          e = e.as(GameEntity)
          logger.debug("Oid::Systems::ActorPosition - Replacing actor position: #{e.actor.position.to_json} with: #{e.position.value.to_json}")
          e.actor.position = e.position.value
        end
      end
    end
  end
end
