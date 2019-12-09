module Oid
  module Shape
    include Oid::GameObject
  end

  class Rectangle
    include Oid::Shape

    property width : Float64
    property height : Float64
    property color : Oid::Color

    def initialize(@width, @height, @color); end
  end

  class Line
    include Oid::Shape

    property end_pos : Oid::Vector2
    property color : Oid::Color

    def initialize(@end_pos, @color); end
  end
end
