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

      # Will go through all contexts and add a `OnEntityCreated` event handler to add the root view as the default parent.
      # This will also add a destroyed listener so that children are destroyed when parent is.
      def init
        contexts.all_contexts.each do |ctx|
          if ctx.class.has_component?(Entitas::Component::Index::Destroyed)
            # Add event handler for `OnEntityCreated`
            ctx.on_entity_created &->on_entity_created(Entitas::Events::OnEntityCreated)
          end
        end
      end

      # Hook for when a entity is created
      def on_entity_created(event : Entitas::Events::OnEntityCreated)
        entity = event.entity
        if entity.is_a?(Oid::RenderableEntity)
          register_listeners(entity)

          if !entity.parent? && entity != root_view
            root_view.add_child(entity)
          end

          # Set a hook to set children of `UiElement`s as UI elements themselves.
          entity.on_child_added &->on_child_added(Oid::RenderableEntity, Oid::RenderableEntity)
        end
      end

      # Recursively update children to be a ui_element
      def on_child_added(parent : Oid::RenderableEntity, child : Oid::RenderableEntity) : Nil
        if parent.ui_element? && !child.ui_element?
          child.ui_element = true
          child.each_child do |cc|
            on_child_added(child, cc)
          end
        end
      end

      def on_destroyed(entity, component : Oid::Components::Destroyed)
        # Destroy children
        if entity.is_a?(Oid::RenderableEntity)
          entity.remove_on_child_added_hook ->on_child_added(Oid::RenderableEntity, Oid::RenderableEntity)

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
