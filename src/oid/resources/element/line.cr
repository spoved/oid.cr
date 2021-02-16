module Oid::Element
  struct Line
    include Oid::Element

    property end_pos : Oid::Vector2
    property color : Oid::Color
    property thickness : Float64 = 1.0
    def initialize(@end_pos, @color, @thickness = 1.0); end
  end
end
