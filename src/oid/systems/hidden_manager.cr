module Oid
  module Systems
    class HiddenManger < ::Entitas::ReactiveSystem
      include Entitas::Systems::InitializeSystem
      include Oid::Services::Helper
      include Oid::Components::Hidden::Listener
      include Oid::Components::Hidden::RemovedListener
      include Oid::EventListener

      protected property contexts : Contexts

      def context
        contexts.stage
      end

      def initialize(@contexts); end

      def init
        @collector = get_trigger(context)
      end

      def get_trigger(context : Entitas::Context) : Entitas::ICollector
        context.create_collector(StageMatcher.any_of(StageMatcher.hidden))
      end

      def filter(entity : StageEntity)
        entity.hidden?
      end

      def register_listeners(entity : Entitas::IEntity)
        entity.add_hidden_listener(self)
        entity.add_hidden_removed_listener(self)
      end

      def on_hidden(entity, component : Oid::Components::Hidden)
        entity.each_child do |child|
          child.add_hidden unless child.hidden?
        end
      end

      def on_hidden_removed(entity)
        entity.each_child do |child|
          child.del_hidden if child.hidden?
        end
      end

      def execute(entities : Array(Entitas::IEntity))
        entities.each do |entity|
          entity = entity.as(StageEntity)
          register_listeners(entity)
          on_hidden(entity, entity.hidden)
        end
      end
    end
  end
end
