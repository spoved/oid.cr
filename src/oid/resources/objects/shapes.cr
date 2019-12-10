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

  ####################
  # 3d Shapes
  ####################

  class Cube
    include Oid::Shape
    property size : Oid::Vector3
    property color : Oid::Color

    def initialize(@size, @color); end
  end

  class CubeWires
    include Oid::Shape
    property size : Oid::Vector3
    property color : Oid::Color

    def initialize(@size, @color); end
  end

  class Grid
    include Oid::Shape

    property size : Int32
    property spacing : Float64

    def initialize(@size, @spacing); end
  end
end
