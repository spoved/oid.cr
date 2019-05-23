require "../src/oid"

RayLib.set_config_flags(RayLib::Enum::Config::WindowResizable.value.to_u8)
RayLib.init_window 640, 480, "Example: hello_world"
TEXT = "Hello, world!"

while !RayLib.window_should_close
  RayLib.begin_drawing
  RayLib.clear_background RayLib::Color::LIME

  w = RayLib.get_screen_width
  h = RayLib.get_screen_height

  font_size = (Math.min(w, h) * 0.2).to_f32
  spacing = (font_size/10).to_f32

  text_size = RayLib.measure_text_ex(RayLib.get_font_default, TEXT, font_size, spacing)

  x = w/2.0 - text_size.x/2.0
  y = h/2.0 - text_size.y/2.0

  RayLib.draw_text_ex(
    RayLib.get_font_default,
    TEXT,
    RayLib::Binding::Vector2.new(x: x, y: y),
    font_size,
    spacing,
    RayLib::Color::BLACK
  )
  RayLib.end_drawing
end

RayLib.close_window
