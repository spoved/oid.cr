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

    property end_x : Float64
    property end_y : Float64
    property color : Oid::Color

    def initialize(@end_x, @end_y, @color); end
  end
end
