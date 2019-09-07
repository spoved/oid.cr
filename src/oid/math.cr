require "math"

module Oid
  module Math
    extend self

    # Rad2Deg = 360 / (PI * 2)
    def rad2deg
      (360 / (::Math::PI * 2))
    end
  end
end
