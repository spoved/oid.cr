require "../../components/scene"

module Oid
  module Systems
    class ViewPosition < Entitas::ReactiveSystem
      def self.new(contexts : Contexts)
        ViewPosition.new(contexts.scene)
      end

      def get_trigger(context : Entitas::Context) : Entitas::ICollector
        context.create_collector(SceneMatcher.position)
      end

      # Select entities with position and view
      def filter(entity : SceneEntity)
        entity.has_position? && entity.has_view?
      end

      def execute(entities : Array(Entitas::IEntity))
        entities.each do |e|
          e = e.as(SceneEntity)

          unless e.has_actor?
            e.add_actor(name: "Scene View")
            e.actor.transform = Oid::Transform.new(e.actor)
          end

          e.actor.transform.position = e.position.value.as(RayLib::Vector2)
        end
      end
    end
  end
end
