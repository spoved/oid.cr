module Oid
  module Systems
    class AddObjectBounds < ::Entitas::ReactiveSystem
      include Oid::Services::Helper
      protected property contexts : Contexts

      def root_view : StageEntity
        view_service.get_root_view(contexts)
      end

      def context
        contexts.stage
      end

      def initialize(@contexts)
        @collector = get_trigger(context)
      end

      def get_trigger(context : Entitas::Context) : Entitas::ICollector
        context.create_collector(StageMatcher.collidable.added)
      end

      def filter(entity : StageEntity)
        entity.collidable? && !entity.destroyed?
      end

      def execute(entities : Array(Entitas::IEntity))
        entities.each do |entity|
          entity = entity.as(StageEntity)

          if entity.view_element?
            entity.replace_bounding_box Oid::CollisionFuncs.bounding_box_for_element(entity)
          elsif entity.asset?
          else
            # UNKNOWN
          end
        end
      end
    end
  end
end
