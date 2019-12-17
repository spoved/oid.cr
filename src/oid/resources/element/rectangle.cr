module Oid::Element
  class Rectangle
    include Oid::Element

    property width : Float64
    property height : Float64
    property color : Oid::Color

    def initialize(@width, @height, @color); end
  end
end
