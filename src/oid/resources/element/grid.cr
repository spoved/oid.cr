module Oid::Element
  class Grid
    include Oid::Element

    property size : Int32
    property spacing : Float64

    def initialize(@size, @spacing); end
  end
end
