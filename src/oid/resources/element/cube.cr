module Oid::Element
  class Cube
    include Oid::Element

    property size : Oid::Vector3
    property color : Oid::Color

    def initialize(@size, @color); end
  end
end
