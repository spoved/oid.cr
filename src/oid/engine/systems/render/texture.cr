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

      private def create_texture(entity : SceneEntity)
        name = entity.texture.name

        unless textures[name]?
          image_path = File.join(
            Oid::Config.settings.asset_dir,
            entity.texture.name
          )

          textures[name] = RayLib.load_texture(image_path)
        end
        textures[name]
      end

      def render(entity : SceneEntity)
        entity.texture.value = create_texture(entity)
        entity.actor.draw(entity)
      end
    end
  end
end
