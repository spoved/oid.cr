module Oid
  module Systems
    class AddView < ::Entitas::ReactiveSystem
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
        context.create_collector(
          StageMatcher.any_of(
            StageMatcher.asset,
            StageMatcher.view_element,
          )
        )
      end

      def filter(entity : StageEntity)
        (entity.asset? || entity.view_element?) && !entity.view?
      end

      def execute(entities : Array(Entitas::IEntity))
        entities.each do |entity|
          entity = entity.as(StageEntity)
          # call the view service to make a new view
          entity.add_view(view_service.init_controller(contexts, entity))

          entity.add_position unless entity.position?
          entity.add_position_type unless entity.position_type?
          entity.add_rotation unless entity.rotation?
          entity.add_scale unless entity.scale?
        end
      end
    end
  end
end
