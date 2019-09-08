require "../../components/scene"

module Oid
  module Systems
    class AddView < Entitas::ReactiveSystem
      def self.new(contexts : Contexts)
        AddView.new(contexts.scene)
      end

      def get_trigger(context : Entitas::Context) : Entitas::ICollector
        context.create_collector(SceneMatcher.texture)
      end

      def filter(entity : SceneEntity)
        entity.has_texture? && !entity.has_view?
      end

      def execute(entities : Array(Entitas::IEntity))
        entities.each do |e|
          e = e.as(SceneEntity)
          e.add_view
        end
      end
    end
  end
end
