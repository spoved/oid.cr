module Oid
  module Systems
    class ActorPosition < Entitas::MultiReactiveSystem
      spoved_logger

      def get_trigger(context : Entitas::Context) : Entitas::ICollector
        context.create_collector(GameMatcher.position)
      end

      def get_trigger(contexts : ::Contexts) : Array(Entitas::ICollector)
        collectors = Array(Entitas::ICollector).new

        contexts.all_contexts.each do |ctx|
          if ctx.class.has_component?(Entitas::Component::Index::Actor)
            collectors << ctx.create_collector(Entitas::Matcher.all_of(::Actor, ::Position))
          end
        end

        collectors
      end

      # Select entities with position and is an actor
      def filter(entity : RenderableEntity)
        entity.position? && entity.actor?
      end

      def execute(entities : Array(Entitas::IEntity))
        entities.each do |e|
          e = e.as(RenderableEntity)
          logger.debug("Oid::Systems::ActorPosition - Replacing actor position: #{e.actor.position.to_json} with: #{e.position.value.to_json}")
          e.actor.position = e.position.value
        end
      end
    end
  end
end
