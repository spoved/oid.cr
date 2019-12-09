require "math"

module Oid
  struct Vector4
    include Oid::Vector

    property x, y, z, w

    @x : Float64
    @y : Float64
    @z : Float64
    @w : Float64

    def values
      {@x, @y, @z, @w}
    end

    def initialize(@x : Float64 = 0.0, @y : Float64 = 0.0, @z : Float64 = 0.0, @w : Float64 = 1.0)
    end

    # Initializes vector with `x`, `y`, `z`, `w`
    def initialize(x, y, z, w)
      @x = x.to_f
      @y = y.to_f
      @z = z.to_f
      @w = w.to_f
    end

    def self.new(angle : Float64, vector : Vector3)
      Vector4.new(x: vector.x, y: vector.y, z: vector.z, w: angle)
    end

    # Zero vector
    def self.zero
      Vector4.new(0.0, 0.0, 0.0, 0.0)
    end

    def zero!
      @x = @y = @z = @w = 0.0
    end

    # Dot product
    def dot(other : Vector4)
      x*other.x + y*other.y + z*other.z
    end

    # Cross product
    def cross(other : Vector4)
      Vector4.new(
        self.y*other.z - self.z*other.y,
        self.z*other.x - self.x*other.z,
        self.x*other.y - self.y*other.x,
        0
      )
    end

    def magnitude
      ::Math.sqrt(self.x**2 + self.y**2 + self.z**2 + self.w**2)
    end

    def +(other : Vector4)
      Vector4.new(self.x + other.x, self.y + other.y, self.z + other.z, self.w + other.w)
    end

    def +(other : Float64)
      Vector4.new(self.x + other, self.y + other, self.z + other, self.w + other)
    end

    def -(other : Vector4)
      Vector4.new(self.x - other.x, self.y - other.y, self.z - other.z, self.w - other.w)
    end

    def -(other : Float64)
      Vector4.new(self.x - other, self.y - other, self.z - other, self.w - other)
    end

    def -
      Vector4.new(-self.x, -self.y, -self.z, -self.w)
    end

    def *(other : Vector4)
      Vector4.new(self.x*other.x, self.y*other.y, self.z*other.z, self.w*other.w)
    end

    def *(other : Float64)
      Vector4.new(self.x*other, self.y * other, self.z * other, self.w * other)
    end

    def /(other : Vector4)
      Vector4.new(self.x/other.x, self.y/other.y, self.z/other.z, self.w/other.w)
    end

    def clone
      Vector4.new(self.x, self.y, self.z, self.w)
    end

    def normalize!
      m = magnitude
      unless m == 0
        inverse = 1.0 / m
        self.x *= inverse
        self.y *= inverse
        self.z *= inverse
        self.w *= inverse
      end
      self
    end

    def distance(other : Vector4)
      (self - other).magnitude
    end

    def ==(other : Vector4)
      self.x == other.x && self.y == other.y && self.z == other.z && self.w == other.w # TODO : Comparsion with EPSILON
    end

    def !=(other : Vector4)
      self.x != other.x || self.y != other.y || self.z != other.z || self.w != other.w # TODO : Comparsion with EPSILON
    end

    def to_v3
      Vector3.new x/w, y/w, z/w
    end
  end
end
