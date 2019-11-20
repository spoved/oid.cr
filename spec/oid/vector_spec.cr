require "../spec_helper"

describe Oid do
  it "converts Quaternion and Euler angles" do
    ea = Vec3.new(1.0, 2.0, Math::PI)
    q = Q.from_euler(ea)
    q.to_euler.should eq(ea)
  end

  it "constructs Vector3 from angle and magnitude" do
    vec = Vec3.new(1.0, 2.0, 3.0)
    new_vec = Vec3.new(vec.angle, vec.magnitude)

    new_vec.mag.should be_close(vec.mag, 0.00000001)
    new_vec.x.should be_close(vec.x, 0.00000001)
    new_vec.y.should be_close(vec.y, 0.00000001)
    new_vec.z.should be_close(vec.z, 0.00000001)

    # Vec3.new(vec.angle, vec.magnitude).should eq(vec)
  end

  it "rotates Vector3" do
    v0 = Vec3.new(1.0, 2.0, 3.0)
    v1 = Vec3.new(-1.0, 2.0, -3.0)
    new_vec = v0.rotate(Vec3.new(0.0, Math::PI, 0.0))
      .rotate(Vec3.new(0.0, -Math::PI, 0.0))

    new_vec.mag.should be_close(v0.mag, 0.00000001)
    new_vec.x.should be_close(v0.x, 0.00000001)
    new_vec.y.should be_close(v0.y, 0.00000001)
    new_vec.z.should be_close(v0.z, 0.00000001)
  end
end

describe Oid::Vector2 do
  it "can be subtracted" do
    vect = Oid::Vector2.new(x: 1, y: 2)
    vect2 = Oid::Vector2.new(x: 6, y: 5)

    new_vect = vect - vect2
    new_vect.x.should eq -5.0
    new_vect.y.should eq -3.0
  end

  it "can be added" do
    new_vect = Oid::Vector2.new(1, 2) + Oid::Vector2.new(6, 5)
    new_vect.x.should eq 7.0
    new_vect.y.should eq 7.0
  end

  it "can be divided" do
    new_vect = Oid::Vector2.new(1, 2) / Oid::Vector2.new(6, 5)
    new_vect.x.should eq 0.16666666666666666
    new_vect.y.should eq 0.4
  end

  it "adds" do
    (vec2(1.0, 2.0) + vec2(3.0, 4.0)).should eq(vec2(4.0, 6.0))
  end

  it "subtracts" do
    (vec2(4.0, 6.0) - vec2(3.0, 4.0)).should eq(vec2(1.0, 2.0))
  end

  it "scales" do
    (vec2(3.0, 4.0)*2.0).should eq(vec2(6.0, 8.0))
  end

  it "divides" do
    (vec2(3.0, 4.0)/2.0).should eq(vec2(1.5, 2.0))
  end

  it "computes magnitude" do
    vec2(2.0, 2.0).mag.should be_close(2.82842712475, 0.00000001)
  end

  it "normalizes" do
    vec2(1.0, 2.0).normalize.mag.should be_close(1.0, 0.00000001)
  end

  it "parses" do
    Vec2.parse("10.1, -3.4").should eq(vec2(10.1, -3.4))
  end

  it "CrystalEdge tests" do
    vec1 = Vec2.new(1.0, 2.0)
    vec2 = Vec2.new(3.0, 4.0)
    vsum = Vec2.new(4.0, 6.0)
    vdif = Vec2.new(-2.0, -2.0)
    vec3 = Vec2.new(-1.0, -2.0)

    (vec1 - vdif).should eq(vec2)
    (vec1 == vec2).should eq(false)
    (vec1 + vec2).should eq(vsum)
    (vec1 - vec2).should eq(vdif)
    (vec1 * vec2).should eq(Vec2.new(3.0, 8.0))
    (vec1 * 2.0).should eq(Vec2.new(2.0, 4.0))
    vec1.should eq(-vec3)
    Vec2.new(3.0, 4.0).magnitude.should eq(5.0)
    (Vec2.new(0.0, 3.0).distance(Vec2.new(4.0, 0.0))).should eq(5.0)
    vec1.should eq(vec1)

    vzero = Vec2.zero
    vec1.zero!
    vec1.should eq(vzero)
    vec1.x = 42.0
    vec1.should_not eq(vzero)
    vec1.should eq(Vec2.new(42.0, 0.0))
    vec1.normalize.magnitude.should eq(1.0)

    vec1.angle.should eq(0.0)
  end
end

describe Oid::Vector3 do
  it "CrystalEdge tests" do
    vec1 = Vec3.zero
    vec2 = Vec3.new(3.0, 4.0, 0.0)
    (vec1 == vec2).should eq(false)
    (vec1 + vec2).should eq(vec2)
    (vec1 - vec2).should eq(-vec2)
    (vec1*vec2).should eq(vec1)

    vec3 = Vec3.new(1.0, 2.0, 3.0)

    (vec2 * vec3).should eq(Vec3.new(3.0, 8.0, 0.0))

    vec4 = Vec3.new(0.0, 3.0, 4.0)
    vec5 = Vec3.new(3.0, 0.0, 4.0)
    m = 5.0
    vec2.magnitude.should eq(5)
    vec4.magnitude.should eq(5)
    vec5.magnitude.should eq(5)
    (vec5*2.0).magnitude.should eq(10)

    vzero = Vec3.zero
    vec5.zero!

    vec5.should eq(vzero)
    vec5.x = 42.0
    vec5.should_not eq(vzero)
    vec5.should eq(Vec3.new(42.0, 0.0, 0.0))
    vec5.normalize.magnitude.should eq(1.0)
  end

  it "adds" do
    (vec3(1.0, 2.0, 3.0) + vec3(3.0, 4.0, 5.0)).should eq(vec3(4.0, 6.0, 8.0))
  end

  it "subtracts" do
    (vec3(4.0, 6.0, 8.0) - vec3(3.0, 4.0, 5.0)).should eq(vec3(1.0, 2.0, 3.0))
  end

  it "scales" do
    (vec3(3.0, 4.0, 5.0)*2.0).should eq(vec3(6.0, 8.0, 10.0))
  end

  it "divides" do
    (vec3(3.0, 4.0, 5.0)/2.0).should eq(vec3(1.5, 2.0, 2.5))
  end

  it "computes magnitude" do
    vec3(2.0, 2.0, 2.0).mag.should be_close(3.46410161514, 0.00000001)
  end

  it "normalizes" do
    vec3(1.0, 2.0, 3.0).normalize.mag.should be_close(1.0, 0.00000001)
  end
end

describe Oid::Vector4 do
  it "CrystalEdge tests" do
    vec1 = Vec4.zero
    vec2 = Vec4.new(1.0, 2.0, 3.0, 4.0)
    vec3 = vec2.clone
    vec3.should eq(vec2)
    (vec2 + vec3).should eq(vec2*2.0)
    (vec2 - vec1).should eq(vec2)
    (vec2*vec3).should eq(Vec4.new(1.0, 4.0, 9.0, 16.0))

    vzero = Vec4.zero
    vec1.zero!

    vec1.should eq(vzero)
    vec1.x = 42.0
    vec1.should_not eq(vzero)
    vec1.should eq(Vec4.new(42.0, 0.0, 0.0, 0.0))
    vec1.normalize.magnitude.should eq(1.0)
  end

  it "adds" do
    (vec4(1.0, 2.0, 3.0, 4.0) + vec4(3.0, 4.0, 5.0, 6.0)).should eq(vec4(4.0, 6.0, 8.0, 10.0))
  end

  it "subtracts" do
    (vec4(4.0, 6.0, 8.0, 10.0) - vec4(3.0, 4.0, 5.0, 6.0)).should eq(vec4(1.0, 2.0, 3.0, 4.0))
  end

  it "scales" do
    (vec4(3.0, 4.0, 5.0, 6.0)*2.0).should eq(vec4(6.0, 8.0, 10.0, 12.0))
  end

  it "divides" do
    (vec4(3.0, 4.0, 5.0, 6.0)/2.0).should eq(vec4(1.5, 2.0, 2.5, 3.0))
  end

  it "converts to a Vec3" do
    vec4(1.0, 2.0, 3.0, 2.0).to_v3.should eq(vec3(0.5, 1.0, 1.5))
  end
end

describe Oid::Quaternion do
  it "CrystalEdge tests" do
    q1 = Q.new(1.0, 1.0, 1.0, 1.0)
    q2 = Q.new(-1.0, -1.0, -1.0, 1.0)
    q3 = Q.new(1.0, 1.0, 1.0, -1.0)
    q1.conjugate.should eq(q2)
    (-(q1.conjugate)).should eq(q3)
    (q2 + q3).should eq(Q.zero)
  end
end
