module Oid::Element
  struct BoundingBox
    include Oid::Element
    property min : Oid::Vector3
    property max : Oid::Vector3

    def initialize(@min, @max); end

    def contains?(pos : Oid::Vector) : Bool
      (
        pos.x < max.x &&
          pos.x > min.x &&
          pos.y < max.y &&
          pos.y > min.y
      )
    end
  end
end
