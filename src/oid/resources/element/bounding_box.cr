module Oid::Element
  struct BoundingBox
    include Oid::Element
    property min : Oid::Vector3
    property max : Oid::Vector3

    def initialize(@min, @max); end
  end
end
