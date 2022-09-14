module Oid
  module Systems
    # This system will watch for entities that have the `Collidable` component added.
    # It will then update the bounding box for them by calling `#replace_bounding_box`
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

          if entity.view?
            entity.replace_bounding_box Oid::CollisionFuncs.bounding_box_for_entity(entity)
          else
            # UNKNOWN
          end
        end
      end
    end
  end
end
