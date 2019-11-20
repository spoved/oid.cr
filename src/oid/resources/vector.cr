module Oid
  module Vector
    macro included
      include JSON::Serializable
    end

    abstract def values
    abstract def zero!

    # Dot product
    abstract def dot(other)
    abstract def cross(other)

    abstract def !=(other)

    def %(other : Vector)
      cross other
    end

    # Performs component multiplication (for dot product see `#dot`)
    abstract def *(other)
    # Performs multiplication
    abstract def *(other : Float64)

    def **(other : Vector)
      dot other
    end

    # Performs component addition
    abstract def +(other)
    # Performs component addition
    abstract def +(other : Float64)
    # Returns negated vector
    abstract def -
    # Performs component subtraction
    abstract def -(other)
    abstract def /(other)

    def /(other : Float64)
      # Multiply by the inverse => only do 1 division instead of 3
      self * (1.0 / other)
    end

    abstract def ==(other)
    abstract def clone

    def clone(&b)
      c = clone
      b.call c
      c
    end

    abstract def distance(other)

    # ditto
    def heading
      angle
    end

    abstract def magnitude

    def mag
      self.magnitude
    end

    def normalize
      clone.normalize!
    end

    # Normalizes current vector
    abstract def normalize!
  end
end

require "./vectors/*"
