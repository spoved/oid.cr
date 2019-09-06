require "../../src/oid"
require "./controller"

# RayLib.set_config_flags(RayLib::Enum::Config::WindowResizable.value.to_u8)

Oid.new_window(title: "Example: tut_01")

controller = GameController.new

class TextRenderer
  def self.render(entity : GameEntity)
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

# Start window fiber
spawn do
  controller.start

  Oid.window.start do
    controller.update

    Contexts.shared_instance.game.get_entities.each do |e|
      TextRenderer.render(e)
    end
  end
end

# Yield to the window
while Oid.window.visable?
  Fiber.yield
end

Oid.global_context.destroy_all_entities
