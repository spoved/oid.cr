module Oid
  module Color
    def self.new(r, g, b, a)
      RayLib::Binding::Color.new(r: r, g: g, b: b, a: a)
    end

    LIGHTGRAY  = RayLib::Binding::Color.new(r: 200, g: 200, b: 200, a: 255)
    GRAY       = RayLib::Binding::Color.new(r: 130, g: 130, b: 130, a: 255)
    DARKGRAY   = RayLib::Binding::Color.new(r: 80, g: 80, b: 80, a: 255)
    YELLOW     = RayLib::Binding::Color.new(r: 253, g: 249, b: 0, a: 255)
    GOLD       = RayLib::Binding::Color.new(r: 255, g: 203, b: 0, a: 255)
    ORANGE     = RayLib::Binding::Color.new(r: 255, g: 161, b: 0, a: 255)
    PINK       = RayLib::Binding::Color.new(r: 255, g: 109, b: 194, a: 255)
    RED        = RayLib::Binding::Color.new(r: 230, g: 41, b: 55, a: 255)
    MAROON     = RayLib::Binding::Color.new(r: 190, g: 33, b: 55, a: 255)
    GREEN      = RayLib::Binding::Color.new(r: 0, g: 228, b: 48, a: 255)
    LIME       = RayLib::Binding::Color.new(r: 0, g: 158, b: 47, a: 255)
    DARKGREEN  = RayLib::Binding::Color.new(r: 0, g: 117, b: 44, a: 255)
    SKYBLUE    = RayLib::Binding::Color.new(r: 102, g: 191, b: 255, a: 255)
    BLUE       = RayLib::Binding::Color.new(r: 0, g: 121, b: 241, a: 255)
    DARKBLUE   = RayLib::Binding::Color.new(r: 0, g: 82, b: 172, a: 255)
    PURPLE     = RayLib::Binding::Color.new(r: 200, g: 122, b: 255, a: 255)
    VIOLET     = RayLib::Binding::Color.new(r: 135, g: 60, b: 190, a: 255)
    DARKPURPLE = RayLib::Binding::Color.new(r: 112, g: 31, b: 126, a: 255)
    BEIGE      = RayLib::Binding::Color.new(r: 211, g: 176, b: 131, a: 255)
    BROWN      = RayLib::Binding::Color.new(r: 127, g: 106, b: 79, a: 255)
    DARKBROWN  = RayLib::Binding::Color.new(r: 76, g: 63, b: 47, a: 255)

    WHITE    = RayLib::Binding::Color.new(r: 255, g: 255, b: 255, a: 255)
    BLACK    = RayLib::Binding::Color.new(r: 0, g: 0, b: 0, a: 255)
    BLANK    = RayLib::Binding::Color.new(r: 0, g: 0, b: 0, a: 0)
    MAGENTA  = RayLib::Binding::Color.new(r: 255, g: 0, b: 255, a: 255)
    RAYWHITE = RayLib::Binding::Color.new(r: 245, g: 245, b: 245, a: 255)
  end
end
