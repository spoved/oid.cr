module Oid
  struct Rectangle
    include Oid::GameObject

    property width : Float64
    property height : Float64

    def initialize(x : Float64, y : Float64, @width, @height)
      @position = Oid::Vector3.new(x: x, y: y, z: 0.0)
    end
  end
end
