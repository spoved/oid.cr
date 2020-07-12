module Oid
  module Systems
    class RelationshipManager
      include Oid::Services::Helper
      include Oid::Components::Destroyed::Listener
      include Oid::EventListener
      include Entitas::Systems::InitializeSystem

      protected property contexts : Contexts
      protected property children_buffer : Set(Oid::RenderableEntity) = Set(Oid::RenderableEntity).new(4)

      def initialize(@contexts); end

      def root_view : StageEntity
        view_service.get_root_view(contexts)
      end

      def register_listeners(entity : Entitas::IEntity)
        entity.add_destroyed_listener(self)
      end

      def init
        contexts.all_contexts.each do |ctx|
          if ctx.class.has_component?(Entitas::Component::Index::Destroyed)
            ctx.on_entity_created do |event|
              entity = event.entity
              if entity.is_a?(Oid::RenderableEntity)
                register_listeners(entity)

                if !entity.parent? && entity != root_view
                  root_view.add_child(entity)
                end
              end
            end
          end
        end
      end

      def on_destroyed(entity, component : Oid::Destroyed)
        # Destroy children
        if entity.is_a?(Oid::RenderableEntity)
          entity.each_child do |child|
            children_buffer.add(child)
          end

          children_buffer.each do |child|
            entity.delete_child(child)
            child.destroyed = true
          end
          children_buffer.clear
        end
      end
    end
  end
end
