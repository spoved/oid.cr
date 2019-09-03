require "../src/oid"

# RayLib.set_config_flags(RayLib::Enum::Config::WindowResizable.value.to_u8)

Oid.new_window(title: "Example: hello_world")

TEXT = "Hello, world!"

class Renderer
  spoved_logger

  MOVE_SIZE = 25

  property offset = 0
  property forward = true

  property window : Oid::Window
  property vector : RayLib::Binding::Vector2 = RayLib::Binding::Vector2.new(x: 0, y: 0)

  def initialize(@window); end

  def do_stuff
    font_size = (Math.min(self.window.screen_w, self.window.screen_h) * 0.2).to_f32
    spacing = (font_size/10).to_f32

    text_size = RayLib.measure_text_ex(
      RayLib.get_font_default,
      TEXT,
      font_size,
      spacing
    )

    # logger.debug("forward: #{self.forward} offset: #{self.offset}")

    if self.offset < MOVE_SIZE && self.forward
      self.offset += 1
    elsif self.offset == MOVE_SIZE
      self.forward = false
      self.offset -= 1
    elsif self.offset == 0
      self.forward = true
      self.offset += 1
    else
      self.offset -= 1
    end

    self.vector.x = self.window.screen_w/2.0 - text_size.x/2.0
    self.vector.y = self.window.screen_h/2.0 - text_size.y/2.0 - self.offset

    RayLib.draw_text_ex(
      RayLib.get_font_default,
      TEXT,
      self.vector,
      font_size,
      spacing,
      RayLib::Color::BLACK
    )
  end
end

renderer = Renderer.new(Oid.window)

# Start window fiber
spawn do
  Oid.window.start do
    renderer.do_stuff
  end
end

# Yield to the window
while Oid.window.visable?
  Fiber.yield
end

Oid.global_context.destroy_all_entities
