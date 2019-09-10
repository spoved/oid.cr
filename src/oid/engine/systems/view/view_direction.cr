require "../../components/scene"

module Oid
  module Systems
    class ViewDirection < Entitas::ReactiveSystem
      def self.new(contexts : Contexts)
        ViewDirection.new(contexts.scene)
      end

      def get_trigger(context : Entitas::Context) : Entitas::ICollector
        context.create_collector(SceneMatcher.direction)
      end

      def filter(entity : SceneEntity)
        entity.has_direction? && entity.has_view?
      end

      def execute(entities : Array(Entitas::IEntity))
        entities.each do |e|
          e = e.as(SceneEntity)

          if e.direction.value.nil?
            raise "No direction value for #{e}"
          end

          ang = e.direction.value.as(Float32)

          e.transform.rotation = RayLib::Quaternion.new(ang - 90, RayLib::Vector3.forward)
        end
      end
    end
  end
end
