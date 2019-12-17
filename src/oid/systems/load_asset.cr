module Oid
  module Systems
    class LoadAsset < ::Entitas::ReactiveSystem
      include Entitas::Systems::InitializeSystem

      protected property contexts : Contexts
      protected setter context : StageContext? = nil
      protected setter view_service : Oid::Service::View? = nil

      def context
        @context ||= contexts.stage
      end

      def view_service
        @view_service ||= contexts.meta.view_service.instance
      end

      def initialize(@contexts); end

      def init
        @view_service = contexts.meta.view_service.instance
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
