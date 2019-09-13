module Oid
  module Systems
    class MultiAddView < Entitas::MultiReactiveSystem
      def get_trigger(contexts : ::Contexts) : Array(Entitas::ICollector)
        collectors = Array(Entitas::ICollector).new

        contexts.all_contexts.each do |ctx|
          if ctx.class.has_component?(Entitas::Component::Index::AssignView)
            collectors << ctx.create_collector(Entitas::Matcher.all_of(AssignView))
          end
        end

        collectors
      end

      def filter(entity : IViewableEntity)
        entity.has_assign_view? && !entity.has_view?
      end

      def execute(entities : Array(Entitas::IEntity))
        entities.each do |e|
          e = e.as(IViewableEntity)
          e.del_assign_view
          e.add_view
        end
      end
    end
  end
end
