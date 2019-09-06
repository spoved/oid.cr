require "../components"

class RenderSystem
  include Entitas::Systems::ExecuteSystem

  getter context : Entitas::IContext
  getter group : Entitas::IGroup

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
    font_size = (Math.min(Oid.window.screen_w, Oid.window.screen_h) * 0.02).to_f32
    spacing = (font_size/10).to_f32

    text_size = RayLib.measure_text_ex(
      RayLib.get_font_default,
      entity.sprite.name.as(String),
      font_size,
      spacing
    )

    RayLib.draw_text_ex(
      RayLib.get_font_default,
      entity.sprite.name.as(String),
      entity.view.game_object.as(Oid::GameObject).transform.position.to_v2,
      font_size,
      spacing,
      RayLib::Color::BLACK
    )
  end
end

class RenderSystems < Entitas::Feature
  def initialize(contexts)
    @name = "Render Systems"
    add RenderSystem.new(contexts)
  end
end
