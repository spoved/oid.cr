module Oid::Element
  struct Grid
    include Oid::Element

    property size : Int32
    property spacing : Float64

    def initialize(@size, _spacing : Int32)
      @spacing = _spacing.to_f32
    end

    def initialize(@size, @spacing); end
  end
end
