module Oid
  alias Color = RayLib::Binding::Color

  module Colors
    def self.new(r, g, b, a)
      Color.new(r: r, g: g, b: b, a: a)
    end

    LIGHTGRAY  = Color.new(r: 200, g: 200, b: 200, a: 255)
    GRAY       = Color.new(r: 130, g: 130, b: 130, a: 255)
    DARKGRAY   = Color.new(r: 80, g: 80, b: 80, a: 255)
    YELLOW     = Color.new(r: 253, g: 249, b: 0, a: 255)
    GOLD       = Color.new(r: 255, g: 203, b: 0, a: 255)
    ORANGE     = Color.new(r: 255, g: 161, b: 0, a: 255)
    PINK       = Color.new(r: 255, g: 109, b: 194, a: 255)
    RED        = Color.new(r: 230, g: 41, b: 55, a: 255)
    MAROON     = Color.new(r: 190, g: 33, b: 55, a: 255)
    GREEN      = Color.new(r: 0, g: 228, b: 48, a: 255)
    LIME       = Color.new(r: 0, g: 158, b: 47, a: 255)
    DARKGREEN  = Color.new(r: 0, g: 117, b: 44, a: 255)
    SKYBLUE    = Color.new(r: 102, g: 191, b: 255, a: 255)
    BLUE       = Color.new(r: 0, g: 121, b: 241, a: 255)
    DARKBLUE   = Color.new(r: 0, g: 82, b: 172, a: 255)
    PURPLE     = Color.new(r: 200, g: 122, b: 255, a: 255)
    VIOLET     = Color.new(r: 135, g: 60, b: 190, a: 255)
    DARKPURPLE = Color.new(r: 112, g: 31, b: 126, a: 255)
    BEIGE      = Color.new(r: 211, g: 176, b: 131, a: 255)
    BROWN      = Color.new(r: 127, g: 106, b: 79, a: 255)
    DARKBROWN  = Color.new(r: 76, g: 63, b: 47, a: 255)

    WHITE    = Color.new(r: 255, g: 255, b: 255, a: 255)
    BLACK    = Color.new(r: 0, g: 0, b: 0, a: 255)
    BLANK    = Color.new(r: 0, g: 0, b: 0, a: 0)
    MAGENTA  = Color.new(r: 255, g: 0, b: 255, a: 255)
    RAYWHITE = Color.new(r: 245, g: 245, b: 245, a: 255)
  end
end
