module Oid
  module Systems
    class MultiDestroy < Entitas::MultiReactiveSystem
      def get_trigger(contexts : ::Contexts) : Array(Entitas::ICollector)
        collectors = Array(Entitas::ICollector).new

        contexts.all_contexts.each do |ctx|
          if ctx.class.has_component?(Entitas::Component::Index::Destroyed)
            collectors << ctx.create_collector(Entitas::Matcher.all_of(Destroyed))
          end
        end

        collectors
      end

      def filter(entity : Destroyed::Helper)
        entity.destroyed?
      end

      def execute(entities : Array(Entitas::IEntity))
        entities.each do |e|
          e.destroy
        end
      end
    end
  end
end
