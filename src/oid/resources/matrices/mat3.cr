module Oid
  module Matrix
    # 3D matrix
    # [x0, x1, x2,
    #  y0, y1, y2,
    #  z0, z1, z2]
    struct Mat3
      include JSON::Serializable

      getter x0, x1, x2, y0, y1, y2, z0, z1, z2

      def initialize(@x0 : Float64, @x1 : Float64, @x2 : Float64,
                     @y0 : Float64, @y1 : Float64, @y2 : Float64,
                     @z0 : Float64, @z1 : Float64, @z2 : Float64)
      end

      def initialize(values : Array(Float64))
        @x0 = values[0]
        @x1 = values[1]
        @x2 = values[2]
        @y0 = values[3]
        @y1 = values[4]
        @y2 = values[5]
        @z0 = values[6]
        @z1 = values[7]
        @z2 = values[8]
      end

      def +(scalar)
        Mat3.new(
          x0 + scalar, x1 + scalar, x2 + scalar,
          y0 + scalar, y1 + scalar, y2 + scalar,
          z0 + scalar, z1 + scalar, z2 + scalar
        )
      end

      def -(scalar)
        Mat3.new(
          x0 - scalar, x1 - scalar, x2 - scalar,
          y0 - scalar, y1 - scalar, y2 - scalar,
          z0 - scalar, z1 - scalar, z2 - scalar
        )
      end

      def +(other)
        Mat3.new(
          x0 + other.x0, x1 + other.x1, x2 + other.x2,
          y0 + other.y0, y1 + other.y1, y2 + other.y2,
          z0 + other.z0, z1 + other.z1, z2 + other.z2
        )
      end

      def -(other)
        Mat3.new(
          x0 - other.x0, x1 - other.x1, x2 - other.x2,
          y0 - other.y0, y1 - other.y1, y2 - other.y2,
          z0 - other.z0, z1 - other.z1, z2 - other.z2
        )
      end

      def *(other : Mat3)
        Mat3.new(
          x0*other.x0 + x1*other.y0 + x2*other.z0,
          x0*other.x1 + x1*other.y1 + x2*other.z1,
          x0*other.x2 + x1*other.y2 + x2*other.z2,
          y0*other.x0 + y1*other.y0 + y2*other.z0,
          y0*other.x1 + y1*other.y1 + y2*other.z1,
          y0*other.x2 + y1*other.y2 + y2*other.z2,
          z0*other.x0 + z1*other.y0 + z2*other.z0,
          z0*other.x1 + z1*other.y1 + z2*other.z1,
          z0*other.x2 + z1*other.y2 + z2*other.z2,
        )
      end

      def self.unit
        Mat3.new(
          1.0, 0.0, 0.0,
          0.0, 1.0, 0.0,
          0.0, 0.0, 1.0
        )
      end
    end
  end
end
