module RayLib
  struct Color
    LIGHTGRAY  = RayLib::Color.new(r: 200, g: 200, b: 200, a: 255)
    GRAY       = RayLib::Color.new(r: 130, g: 130, b: 130, a: 255)
    DARKGRAY   = RayLib::Color.new(r: 80, g: 80, b: 80, a: 255)
    YELLOW     = RayLib::Color.new(r: 253, g: 249, b: 0, a: 255)
    GOLD       = RayLib::Color.new(r: 255, g: 203, b: 0, a: 255)
    ORANGE     = RayLib::Color.new(r: 255, g: 161, b: 0, a: 255)
    PINK       = RayLib::Color.new(r: 255, g: 109, b: 194, a: 255)
    RED        = RayLib::Color.new(r: 230, g: 41, b: 55, a: 255)
    MAROON     = RayLib::Color.new(r: 190, g: 33, b: 55, a: 255)
    GREEN      = RayLib::Color.new(r: 0, g: 228, b: 48, a: 255)
    LIME       = RayLib::Color.new(r: 0, g: 158, b: 47, a: 255)
    DARKGREEN  = RayLib::Color.new(r: 0, g: 117, b: 44, a: 255)
    SKYBLUE    = RayLib::Color.new(r: 102, g: 191, b: 255, a: 255)
    BLUE       = RayLib::Color.new(r: 0, g: 121, b: 241, a: 255)
    DARKBLUE   = RayLib::Color.new(r: 0, g: 82, b: 172, a: 255)
    PURPLE     = RayLib::Color.new(r: 200, g: 122, b: 255, a: 255)
    VIOLET     = RayLib::Color.new(r: 135, g: 60, b: 190, a: 255)
    DARKPURPLE = RayLib::Color.new(r: 112, g: 31, b: 126, a: 255)
    BEIGE      = RayLib::Color.new(r: 211, g: 176, b: 131, a: 255)
    BROWN      = RayLib::Color.new(r: 127, g: 106, b: 79, a: 255)
    DARKBROWN  = RayLib::Color.new(r: 76, g: 63, b: 47, a: 255)

    WHITE    = RayLib::Color.new(r: 255, g: 255, b: 255, a: 255)
    BLACK    = RayLib::Color.new(r: 0, g: 0, b: 0, a: 255)
    BLANK    = RayLib::Color.new(r: 0, g: 0, b: 0, a: 0)
    MAGENTA  = RayLib::Color.new(r: 255, g: 0, b: 255, a: 255)
    RAYWHITE = RayLib::Color.new(r: 245, g: 245, b: 245, a: 255)

    property r : UInt8
    property g : UInt8
    property b : UInt8
    property a : UInt8

    def initialize(@r : UInt8, @g : UInt8, @b : UInt8, @a : UInt8); end

    def self.new(unwrap : ::Pointer(Binding::Color))
      unwrap.as(Pointer(Color)).value
    end

    def self.new(unwrap : Binding::Color)
      unwrap.unsafe_as(Color)
    end

    def to_unsafe
      unsafe_as(Binding::Color)
    end
  end
end
