require "../components"

class RenderSystem
  include Entitas::Systems::ExecuteSystem

  getter context : Entitas::IContext
  getter group : Entitas::IGroup
  getter textures : Hash(String, RayLib::Texture2D) = Hash(String, RayLib::Texture2D).new

  def initialize(contexts : Contexts)
    @context = contexts.game
    @group = @context.get_group(GameMatcher.view)
  end

  def execute
    group.entities.each do |e|
      render(e.as(GameEntity))
    end
  end

  def render(entity : GameEntity)
    sprite_name = entity.sprite.name.as(String)

    unless textures[sprite_name]?
      image_path = File.join(
        ASSET_PATH,
        entity.sprite.name.as(String)
      )

      textures[sprite_name] = RayLib.load_texture(image_path)
    end

    trans = entity.view.actor.as(Oid::Actor).transform
    position = trans.position.to_v2
    rotation = entity.direction.value

    RayLib.draw_texture_ex(
      textures[sprite_name],
      position,
      rotation.as(Float32),
      0.1f32,
      RayLib::Color::WHITE
    )
  end
end

class RenderSystems < Entitas::Feature
  def initialize(contexts)
    @name = "Render Systems"
    add RenderSystem.new(contexts)
  end
end
