module Oid::Element
  class CubeWires
    include Oid::Element
    property size : Oid::Vector3
    property color : Oid::Color

    def initialize(@size, @color); end
  end
end
