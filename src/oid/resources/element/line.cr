module Oid::Element
  struct Line
    include Oid::Element

    property end_pos : Oid::Vector2
    property color : Oid::Color

    def initialize(@end_pos, @color); end
  end
end
