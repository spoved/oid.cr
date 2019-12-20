module Oid
  module Systems
    class AddPositionComponents < ::Entitas::ReactiveSystem
      include Oid::Services::Helper

      protected property contexts : Contexts

      def context
        contexts.stage
      end

      def initialize(@contexts)
        @collector = get_trigger(context)
      end

      def get_trigger(context : Entitas::Context) : Entitas::ICollector
        context.create_collector(StageMatcher.position.added)
      end

      def filter(entity : StageEntity)
        entity.position?
      end

      def execute(entities : Array(Entitas::IEntity))
        entities.each do |entity|
          entity = entity.as(StageEntity)

          entity.add_position_type unless entity.position_type?
          entity.add_rotation unless entity.rotation?
          entity.add_scale unless entity.scale?
        end
      end
    end
  end
end
