module RayLib
  struct Vector2
    # Shorthand for writing Vector3.new(x: 0, y: 0, z: 0).
    def self.zero
      Vector2.new(x: 0, y: 0)
    end

    # Convert `Vector2` to a `Vector3`
    #
    # ```
    # Vector2.new(1, 2).to_v3 # => RayLib::Vector4(@x=1.0, @y=2.0, @z=0.0)
    # ```
    def to_v3
      Vector3.new(x: self.x, y: self.y, z: 0)
    end

    # Subtracts one vector from another.
    #
    # ```
    # Vector2.new(1, 2) - Vector2.new(6, 5) # => RayLib::Vector2(@x=-5.0, @y=-3.0)
    # ```
    def -(value)
      Vector2.new(x: self.x - value.x, y: self.y - value.y)
    end
  end

  struct Vector3
    # Convert `Vector3` to a `Vector4`
    #
    # ```
    # Vector3.new(1, 2, 3).to_v4 # => RayLib::Vector4(@x=1.0, @y=2.0, @z=3.0, @w=0.0)
    # ```
    def to_v4
      Vector4.new(x: self.x, y: self.y, z: self.z, w: 0)
    end

    # Subtracts one vector from another.
    #
    # ```
    # Vector3.new(1, 2, 3) - Vector3.new(6, 5, 4) # => RayLib::Vector3(@x=-5.0, @y=-3.0, @z=-1.0)
    # ```
    def -(value)
      Vector3.new(x: self.x - value.x, y: self.y - value.y, z: self.z - value.z)
    end

    # Shorthand for writing Vector3.new(x: 0, y: 1, z: 0).
    def self.up
      Vector3.new(x: 0, y: 1, z: 0)
    end

    # Shorthand for writing Vector3.new(x: 0, y: -1, z: 0).
    def self.down
      Vector3.new(x: 0, y: -1, z: 0)
    end

    # Shorthand for writing Vector3.new(x: 0, y: 0, z: 1).
    def self.forward
      Vector3.new(x: 0, y: 0, z: 1)
    end

    # Shorthand for writing Vector3.new(x: 0, y: 0, z: -1).
    def self.back
      Vector3.new(x: 0, y: 0, z: -1)
    end

    # Shorthand for writing Vector3.new(x: 1, y: 0, z: 0).
    def self.right
      Vector3.new(x: 1, y: 0, z: 0)
    end

    # Shorthand for writing Vector3.new(x: -1, y: 0, z: 0).
    def self.left
      Vector3.new(x: -1, y: 0, z: 0)
    end

    # Shorthand for writing Vector3.new(x: 0, y: 0, z: 0).
    def self.zero
      Vector3.new(x: 0, y: 0, z: 0)
    end
  end

  struct Vector4
    # Subtracts one vector from another.
    #
    # ```
    # Vector4.new(1, 2, 3, 4) - Vector4.new(6, 5, 4, 3) # => RayLib::Vector4(@x=-5.0, @y=-3.0, @z=-1.0, @w=1.0)
    # ```
    def -(value)
      Vector4.new(x: self.x - value.x, y: self.y - value.y, z: self.z - value.z, w: self.w - value.w)
    end

    # Shorthand for writing Vector4.new(x: 1, y: 1, z: 1, w: 1).
    def self.one
      Vector4.new(x: 1, y: 1, z: 1, w: 1)
    end

    # Shorthand for writing Vector4.new(x: 0, y: 0, z: 0, w: 0).
    def self.zero
      Vector4.new(x: 0, y: 0, z: 0, w: 0)
    end

    def self.new(angle : Float32, vector : Vector3)
      Vector4.new(x: vector.x, y: vector.y, z: vector.z, w: angle)
    end
  end
end
