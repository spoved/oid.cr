module Oid
  struct Color
    include JSON::Serializable

    property r : UInt8
    property g : UInt8
    property b : UInt8
    property a : UInt8

    def initialize(@r : UInt8, @g : UInt8, @b : UInt8, @a : UInt8 = 255); end

    LIGHTGRAY  = Color.new(r: 200, g: 200, b: 200)
    GRAY       = Color.new(r: 130, g: 130, b: 130)
    DARKGRAY   = Color.new(r: 80, g: 80, b: 80)
    YELLOW     = Color.new(r: 253, g: 249, b: 0)
    GOLD       = Color.new(r: 255, g: 203, b: 0)
    ORANGE     = Color.new(r: 255, g: 161, b: 0)
    PINK       = Color.new(r: 255, g: 109, b: 194)
    RED        = Color.new(r: 230, g: 41, b: 55)
    MAROON     = Color.new(r: 190, g: 33, b: 55)
    GREEN      = Color.new(r: 0, g: 228, b: 48)
    LIME       = Color.new(r: 0, g: 158, b: 47)
    DARKGREEN  = Color.new(r: 0, g: 117, b: 44)
    SKYBLUE    = Color.new(r: 102, g: 191, b: 255)
    BLUE       = Color.new(r: 0, g: 121, b: 241)
    DARKBLUE   = Color.new(r: 0, g: 82, b: 172)
    PURPLE     = Color.new(r: 200, g: 122, b: 255)
    VIOLET     = Color.new(r: 135, g: 60, b: 190)
    DARKPURPLE = Color.new(r: 112, g: 31, b: 126)
    BEIGE      = Color.new(r: 211, g: 176, b: 131)
    BROWN      = Color.new(r: 127, g: 106, b: 79)
    DARKBROWN  = Color.new(r: 76, g: 63, b: 47)
    WHITE      = Color.new(r: 255, g: 255, b: 255)
    BLACK      = Color.new(r: 0, g: 0, b: 0)
    BLANK      = Color.new(r: 0, g: 0, b: 0, a: 0)
    MAGENTA    = Color.new(r: 255, g: 0, b: 255)
    RAYWHITE   = Color.new(r: 245, g: 245, b: 245)
  end
end
