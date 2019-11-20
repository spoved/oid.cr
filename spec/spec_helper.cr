require "spec"
require "../src/oid"

alias Mat3=Oid::Matrix::Mat3
alias Mat4=Oid::Matrix::Mat4
alias Vec2 = Oid::Vector2
alias Vec3 = Oid::Vector3
alias Vec4 = Oid::Vector4


# convenience function for creating Vec2
def vec2(x : Float64 = 0.0, y : Float64 = 0.0)
  Oid::Vector2.new(x, y)
end

# convenience function for creating Vec3
def vec3(x : Float64 = 0.0, y : Float64 = 0.0, z : Float64 = 0.0)
  Oid::Vector3.new(x, y, z)
end

# convenience function for creating Vec4
def vec4(x : Float64 = 0.0, y : Float64 = 0.0, z : Float64 = 0.0, w : Float64 = 0.0)
  Oid::Vector4.new(x, y, z, w)
end

# convenience function for creating Mat3
def mat3(x0 : Float64, x1 : Float64, x2 : Float64,
         y0 : Float64, y1 : Float64, y2 : Float64,
         z0 : Float64, z1 : Float64, z2 : Float64)
  Mat3.new(x0, x1, x2, y0, y1, y2, z0, z1, z2)
end

# convenience function for creating Mat3
def mat4(x0 : Float64, x1 : Float64, x2 : Float64, x3 : Float64,
         y0 : Float64, y1 : Float64, y2 : Float64, y3 : Float64,
         z0 : Float64, z1 : Float64, z2 : Float64, z3 : Float64,
         w0 : Float64, w1 : Float64, w2 : Float64, w3 : Float64)
  Mat4.new(x0, x1, x2, x3, y0, y1, y2, y3, z0, z1, z2, z3, w0, w1, w2, w3)
end
