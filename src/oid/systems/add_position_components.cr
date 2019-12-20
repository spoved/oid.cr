module Oid
  module Systems
    class AddPositionComponents < ::Entitas::ReactiveSystem
      include Oid::Services::Helper
      include Oid::Destroyed::Listener

      protected property contexts : Contexts
      protected property children_buffer : Set(Oid::RenderableEntity) = Set(Oid::RenderableEntity).new(4)

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
        context.create_collector(StageMatcher.position.added)
      end

      def filter(entity : StageEntity)
        entity.position? && !entity.destroyed?
      end

      def execute(entities : Array(Entitas::IEntity))
        entities.each do |entity|
          entity = entity.as(StageEntity)

          entity.add_position_type unless entity.position_type?
          entity.add_rotation unless entity.rotation?
          entity.add_scale unless entity.scale?
          entity.add_destroyed_listener(self)
          if !entity.parent? && entity != root_view
            root_view.add_child(entity)
          end
        end
      end

      def on_destroyed(entity, component : Oid::Destroyed)
        puts "Entity: #{entity} was destroyed"
        # Destroy children
        if entity.is_a?(Oid::RenderableEntity)
          entity.each_child do |child|
            children_buffer.add(child)
          end

          children_buffer.each do |child|
            puts "Entity: #{entity} destroying child: #{child}"
            entity.delete_child(child)
            child.destroyed = true
          end
          children_buffer.clear
        end
      end
    end
  end
end
