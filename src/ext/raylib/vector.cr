require "./binding"

module RayLib
  struct Vector3
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
    # Shorthand for writing Vector4.new(x: 1, y: 1, z: 1, w: 1).
    def self.one
      Vector4.new(x: 1, y: 1, z: 1, w: 1)
    end

    # Shorthand for writing Vector4.new(x: 0, y: 0, z: 0, w: 0).
    def self.zero
      Vector4.new(x: 0, y: 0, z: 0, w: 0)
    end
    #
    # def self.new
    #   Vector3.new(0, 0, 0, 0)
    # end
    #
    # def self.new(angle : Float32, vector : Vector3)
    #   Vector3.new(x: vector.x, y: vector.y, z: vector.z, w: angle)
    # end
    #
    # def initialize(@x : Float32, @y : Float32, @z : Float32, @w : Float32); end
  end
end
