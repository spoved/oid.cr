require "math"
require "./vector3"

module Oid
  struct Quaternion
    include JSON::Serializable

    property x, y, z, w

    @x : Float64
    @y : Float64
    @z : Float64
    @w : Float64

    def initialize(@x, @y, @z, @w : Float64)
    end

    def values
      {@x, @y, @z, @w}
    end

    # Converts euler angles to Quaternion
    # Angles are in radians!
    def self.from_euler(euler : Vector3)
      sx, sy, sz = euler.x / 2.0, euler.y / 2.0, euler.z / 2.0
      c1 = Math.cos sy
      s1 = Math.sin sy
      c2 = Math.cos sx
      s2 = Math.sin sx
      c3 = Math.cos sz
      s3 = Math.sin sz
      new(
        c1 * c2 * s3 + s1 * s2 * c3,
        s1 * c2 * c3 + c1 * s2 * s3,
        c1 * s2 * c3 - s1 * c2 * s3,
        c1 * c2 * c3 - s1 * s2 * s3
      )
    end

    def to_euler
      sqw = self.w**2
      sqx = self.x**2
      sqy = self.y**2
      sqz = self.z**2
      unit = sqx + sqy + sqz + sqw
      test = self.x*self.y + self.z*self.w
      if test > 0.4999 * unit
        Vector3.new(
          Math::PI/2,
          2 * Math.atan2(self.x, self.w),
          0.0
        )
      elsif test < -0.4999 * unit
        Vector3.new(
          -Math::PI/2,
          -2 * Math.atan2(self.x, self.w),
          0.0
        )
      else
        Vector3.new(
          Math.asin(2*test/unit),
          Math.atan2(2 * self.y * self.w - 2 * self.x * self.z, sqx - sqy - sqz + sqw),
          Math.atan2(2 * self.x * self.w - 2 * self.y * self.z, -sqx + sqy - sqz + sqw)
        )
      end
    end

    # Zero vector
    def self.zero
      new(0.0, 0.0, 0.0, 0.0)
    end

    # Dot product
    def dot(other : Quaternion)
      x*other.x + y*other.y + z*other.z
    end

    def **(other : Quaternion)
      dot other
    end

    def norm
      self.x**2 + self.y**2 + self.z**2 + self.w**2
    end

    def magnitude
      Math.sqrt(self.x**2 + self.y**2 + self.z**2 + self.w**2)
    end

    def +(other : Quaternion)
      Quaternion.new(self.x + other.x, self.y + other.y, self.z + other.z, self.w + other.w)
    end

    def -(other : Quaternion)
      Quaternion.new(self.x - other.x, self.y - other.y, self.z - other.z, self.w - other.w)
    end

    def -
      Quaternion.new(-self.x, -self.y, -self.z, -self.w)
    end

    def *(other : Quaternion)
      Quaternion.new(self.x*other.x, self.y*other.y, self.z*other.z, self.w*other.w)
    end

    def *(other : Vector3)
      Quaternion.new(
        self.w * other.x + self.y * other.z - self.z * other.y,
        self.w * other.y - self.x * other.z + self.z * other.x,
        self.w * other.z + self.x * other.y - self.y * other.x,
        0 - self.x*other.x - self.y*other.y - self.z * other.z
      )
    end

    def *(other : Float64)
      Quaternion.new(self.x*other, self.y * other, self.z * other, self.w * other)
    end

    def inverse
      if norm == 0.0
        self
      else
        self.conjugate.normalize
      end
    end

    def conjugate
      Quaternion.new(-self.x, -self.y, -self.z, self.w)
    end

    def pure?
      self.w == 0.0
    end

    def unit?
      norm == 1.0
    end

    def axis
      Vector3.new(x, y, z)
    end

    def axis=(v : Vector3)
      @x, @y, @z = v.x, v.y, v.z
    end

    def angle
      @w
    end

    def angle=(v : Float64)
      @w = v
    end

    def clone
      Quaternion.new(self.x, self.y, self.z, self.w)
    end

    def normalize!
      m = magnitude
      unless m == 0
        self.x /= m
        self.y /= m
        self.z /= m
        self.w /= m
      end
      self
    end

    def normalize
      clone.normalize!
    end

    def_equals x, y, z, w

    def !=(other : Quaternion)
      self.x != other.x || self.y != other.y || self.z != other.z || self.w != other.w
    end

    def to_s
      "{X : #{x}; Y : #{y}, Z : #{z}, W: : #{w}}"
    end

    def self.lerp(qstart, qend : Quaternion, percent : Float64)
      if percent == 0
        qstart
      elsif percent == 1
        qend
      else
        f1 = 1.0 - percent
        f2 = percent

        Quaternion.new(
          f1 * qstart.x + f2 * qend.x,
          f1 * qstart.y + f2 * qend.y,
          f1 * qstart.z + f2 * qend.z,
          f1 * qstart.w + f2 * qend.w
        )
      end
    end

    def self.nlerp(qstart, qend : Quaternion, percent : Float64)
      lerp(qstart, qend, percent).normalize
    end

    def self.slerp(qstart, qend : Quaternion, percent : Float64)
      if percent == 0
        qstart
      elsif percent == 1
        qend
      else
        dot = qstart**qend
        if dot == 0
          lerp(qstart, qend, percent)
        elsif dot < 0
          -slerp(qstart, -qend, percent)
        else
          dot = dot.clamp(-1.0, 1.0)
          theta = Math.acos(dot)
          s = Math.sin(theta)
          # f1 = Math.sin((1.0 - percent) * theta) / s
          f1 = Math.sin(percent * theta) / s
          Quaternion.new(
            f1 * qstart.x + f2 * qend.x,
            f1 * qstart.y + f2 * qend.y,
            f1 * qstart.z + f2 * qend.z,
            f1 * qstart.w + f2 * qend.w
          )
        end
      end
    end
  end

  struct Vector3
    def rotate(q : Quaternion)
      qi = q.conjugate
      qq = (q*self)*qi
      Vector3.new(
        qq.x,
        qq.y,
        qq.z
      )
    end

    def reflect(q : Quaternion)
      qq = ((q*self)*q).normalize
      Vector3.new(
        qq.x,
        qq.y,
        qq.z
      )
    end
  end
end
