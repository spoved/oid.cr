require "../../components/scene"

module Oid
  module Systems
    class RenderTexture
      include Entitas::Systems::ExecuteSystem

      getter context : Entitas::IContext
      getter group : Entitas::IGroup
      getter textures : Hash(String, RayLib::Texture2D) = Hash(String, RayLib::Texture2D).new

      def initialize(contexts : Contexts)
        @context = contexts.scene
        @group = @context.get_group(SceneMatcher.all_of(View, Texture, Actor))
      end

      def execute
        group.entities.each do |e|
          render(e.as(SceneEntity))
        end
      end

      def render(entity : SceneEntity)
        name = entity.texture.name

        unless textures[name]?
          image_path = File.join(
            ".",
            entity.texture.name
          )

          textures[name] = RayLib.load_texture(image_path)
        end

        trans = entity.actor.transform
        position = trans.position.to_v2
        rotation = entity.direction.value

        RayLib.draw_texture_ex(
          textures[name],
          position,
          rotation,
          0.1f32,
          RayLib::Color::WHITE
        )
      end
    end
  end
end
