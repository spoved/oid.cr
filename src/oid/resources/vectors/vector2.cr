require "math"

module Oid
  # Representation of 2D vector
  struct Vector2
    include Oid::Vector

    property x, y

    @x : Float64
    @y : Float64

    # Converts vector to a tuple of values
    def values
      {@x, @y}
    end

    # Initializes vector with `x` and `y`
    def initialize(@x, @y)
    end

    # Initializes vector with `x` and `y`
    def initialize(x, y)
      @x = x.to_f
      @y = y.to_f
    end

    def self.parse(s)
      comps = s.split(",")
      x = comps[0].to_f
      y = comps[1].to_f
      Vector2.new x, y
    end

    # Zero vector
    def self.zero
      Vector2.new(0.0, 0.0)
    end

    # Fills current vector with zero
    def zero!
      @x = @y = 0.0
      self
    end

    # Returns dot product of two vectors
    def dot(other)
      x*other.x + y*other.y
    end

    # Returns cross product of two vectors
    def cross(other)
      Vector2.new(self.x*other.y - self.y*other.x, self.y*other.x - self.x*other.y)
    end

    # Returns magnitude of this vector
    def magnitude
      ::Math.sqrt(self.x**2 + self.y**2)
    end

    # Returns angle between two vectors
    def angle(other : Vector)
      self**other / (self.magnitude * other.magnitude)
    end

    # Returns direction of a vector
    def angle
      ::Math.atan2(self.y, self.x)
    end

    # Performs component addition
    def +(other : Vector)
      Vector2.new(self.x + other.x, self.y + other.y)
    end

    # Performs component addition
    def +(other : Float64)
      Vector2.new(self.x + other, self.y + other)
    end

    # Performs component subtraction
    def -(other : Vector)
      Vector2.new(self.x - other.x, self.y - other.y)
    end

    # Performs component subtraction
    def -(other : Float64)
      Vector2.new(self.x - other, self.y - other)
    end

    # Returns negated vector
    def -
      Vector2.new(-self.x, -self.y)
    end

    # Performs component multiplication (for dot product see `#dot`)
    def *(other : Vector)
      Vector2.new(self.x*other.x, self.y*other.y)
    end

    # Performs multiplication
    def *(other : Float64)
      Vector2.new(self.x*other, self.y * other)
    end

    # Performs component division
    def /(other : Vector)
      Vector2.new(self.x/other.x, self.y/other.y)
    end

    # Clones this vector and passes it into a block if given
    def clone
      Vector2.new(self.x, self.y)
    end

    # Normalizes current vector
    def normalize!
      m = magnitude
      unless m == 0
        inverse = 1.0 / m
        self.x *= inverse
        self.y *= inverse
      end
      self
    end

    # Finds normal axis between two vectors
    def find_normal_axis(other)
      (self % other).normalize
    end

    # Finds distance between two vectors
    def distance(other : Vector)
      (self - other).magnitude
    end

    def ==(other)
      self.x == other.x && self.y == other.y
    end

    def !=(other)
      self.x != other.x || self.y != other.y
    end

    def to_v3
      Vector3.new(self.x, self.y, 0)
    end

    def to_v4
      self.to_v3.to_v4
    end
  end
end
