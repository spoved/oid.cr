module Oid
  module Systems
    class LoadAsset < ::Entitas::ReactiveSystem
      include Entitas::Systems::InitializeSystem
      include Oid::Services::Helper

      protected property contexts : Contexts
      protected setter context : StageContext? = nil

      def context
        contexts.stage
      end

      def initialize(@contexts); end

      def init
        @context = contexts.stage
        @collector = get_trigger(context)
      end

      def get_trigger(context : Entitas::Context) : Entitas::ICollector
        context.create_collector(StageMatcher.asset.added)
      end

      def filter(entity : StageEntity)
        entity.asset? && !entity.asset_loaded?
      end

      def execute(entities : Array(Entitas::IEntity))
        entities.each do |entity|
          entity = entity.as(StageEntity)
          # call the view service to make a new view
          view_service.load_asset(contexts, entity, entity.asset.type, entity.asset.name)
          entity.asset_loaded = true
        end
      end
    end
  end
end
