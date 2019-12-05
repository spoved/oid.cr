module Oid
  module Systems
    class LoadAsset < ::Entitas::ReactiveSystem
      include Entitas::Systems::InitializeSystem

      protected property contexts : Contexts
      protected setter context : GameContext? = nil
      protected setter view_service : Oid::Service::View? = nil

      def context
        @context ||= contexts.game
      end

      def view_service
        @view_service ||= contexts.meta.view_service.instance
      end

      def initialize(@contexts); end

      def init
        @view_service = contexts.meta.view_service.instance
        @context = contexts.game
        @collector = get_trigger(context)
      end

      def get_trigger(context : Entitas::Context) : Entitas::ICollector
        context.create_collector(GameMatcher.asset)
      end

      def filter(entity)
        entity.as(GameEntity).has_asset? && !entity.as(GameEntity).has_view?
      end

      def execute(entities : Array(Entitas::IEntity))
        entities.each do |entity|
          entity = entity.as(GameEntity)
          # call the view service to make a new view
          view_service.load_asset(contexts, entity, entity.asset.type, entity.asset.name)
          # entity.replace_view view unless view.nil?
        end
      end
    end
  end
end
