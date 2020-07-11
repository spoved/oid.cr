module Oid
  module Systems
    class ProcessInput < Entitas::ReactiveSystem
      spoved_logger(bind: true)

      include Entitas::Systems::ExecuteSystem

      protected property contexts : Contexts
      protected property context : InputContext

      def initialize(@contexts)
        @context = @contexts.input
        @collector = get_trigger(@context)
      end

      def filter(entity : InputEntity)
        entity.input?
      end

      def get_trigger(context : Entitas::Context) : Entitas::ICollector
        context.create_collector(InputMatcher.input)
      end

      def execute(entities : Array(Entitas::IEntity))
        # TODO: delete piece where input is over
        entity = entities.first.as(InputEntity)
        # FIXME: Need to do correct positioning
        pos = (entity.input.position / Oid::Vector2.new(800, 600))*10
        e = contexts.stage
          .get_entity_index(Entitas::Contexts::PIECE_POSITION_INDEX)
          .as(Entitas::PrimaryEntityIndex(StageEntity, Oid::Vector2))
          .get_entity(Oid::Vector2.new(pos.x.to_i, pos.y.to_i))

        if !e.nil? && e.interactive?
          logger.warn { "Destroying #{e}" }
          e.destroyed = true
        end
      end
    end
  end
end
