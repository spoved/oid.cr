require "../spec_helper"

describe RayLib::Vector2 do
  it "can be cast via pointer" do
    vect = RayLib::Vector2.new(x: 10, y: 2)

    vect.x.should eq 10

    ptr = pointerof(vect)
    ptr.value.should be_a RayLib::Vector2
    b_prt = ptr.as(Pointer(RayLib::Binding::Vector2))
    b_prt.value.should_not be_a RayLib::Vector2
    b_prt.value.should be_a RayLib::Binding::Vector2

    bvect = b_prt.value
    bvect.x.should eq 10
  end

  it "can be passed via pointer to the wrapper" do
    bvect = RayLib::Binding::Vector2.new(x: 10, y: 3)
    vect = RayLib::Vector2.new(unwrap: pointerof(bvect))
    vect.should be_a RayLib::Vector2
  end

  it "can be subtracted" do
    vect = RayLib::Vector2.new(x: 1, y: 2)
    vect2 = RayLib::Vector2.new(x: 6, y: 5)

    new_vect = vect - vect2
    new_vect.x.should eq -5.0
    new_vect.y.should eq -3.0
  end

  it "can be added" do
    new_vect = RayLib::Vector2.new(1, 2) + RayLib::Vector2.new(6, 5)
    new_vect.x.should eq 7.0
    new_vect.y.should eq 7.0
  end

  it "can be divided" do
    new_vect = RayLib::Vector2.new(1, 2) / RayLib::Vector2.new(6, 5)
    new_vect.x.should eq 0.16666667f32
    new_vect.y.should eq 0.4f32
  end
end

alias V2 = RayLib::Vector2
alias V3 = RayLib::Vector3
alias V4 = RayLib::Vector4

describe RayLib::Vector2 do
  it "works" do
    vec1 = V2.new(1.0, 2.0)
    vec2 = V2.new(3.0, 4.0)
    vsum = V2.new(4.0, 6.0)
    vdif = V2.new(-2.0, -2.0)
    vec3 = V2.new(-1.0, -2.0)

    (vec1 - vdif).should eq(vec2)
    (vec1 == vec2).should eq(false)
    (vec1 + vec2).should eq(vsum)
    (vec1 - vec2).should eq(vdif)
    (vec1 * vec2).should eq(V2.new(3.0, 8.0))
    (vec1 * 2.0).should eq(V2.new(2.0, 4.0))
    vec1.should eq(-vec3)
    V2.new(3.0, 4.0).magnitude.should eq(5.0)
    (V2.new(0.0, 3.0).distance(V2.new(4.0, 0.0))).should eq(5.0)
    vec1.should eq(vec1)

    vzero = V2.zero
    vec1.zero!
    vec1.should eq(vzero)
    vec1.x = 42.0f32
    vec1.should_not eq(vzero)
    vec1.should eq(V2.new(42.0, 0.0))
    vec1.normalize.magnitude.should eq(1.0)

    vec1.angle.should eq(0.0)
  end
end

describe RayLib::Vector3 do
  it "works" do
    vec1 = V3.zero
    vec2 = V3.new(3.0, 4.0, 0.0)
    (vec1 == vec2).should eq(false)
    (vec1 + vec2).should eq(vec2)
    (vec1 - vec2).should eq(-vec2)
    (vec1*vec2).should eq(vec1)

    vec3 = V3.new(1.0, 2.0, 3.0)

    (vec2 * vec3).should eq(V3.new(3.0, 8.0, 0.0))

    vec4 = V3.new(0.0, 3.0, 4.0)
    vec5 = V3.new(3.0, 0.0, 4.0)
    m = 5.0
    vec2.magnitude.should eq(5)
    vec4.magnitude.should eq(5)
    vec5.magnitude.should eq(5)
    (vec5*2.0).magnitude.should eq(10)

    vzero = V3.zero
    vec5.zero!

    vec5.should eq(vzero)
    vec5.x = 42.0f32
    vec5.should_not eq(vzero)
    vec5.should eq(V3.new(42.0, 0.0, 0.0))
    vec5.normalize.magnitude.should eq(1.0)
  end
end

describe RayLib::Vector4 do
  it "passes Vector4 tests" do
    vec1 = V4.zero
    vec2 = V4.new(1.0, 2.0, 3.0, 4.0)
    vec3 = vec2.clone
    vec3.should eq(vec2)
    (vec2 + vec3).should eq(vec2*2.0)
    (vec2 - vec1).should eq(vec2)
    (vec2*vec3).should eq(V4.new(1.0, 4.0, 9.0, 16.0))

    vzero = V4.zero
    vec1.zero!

    vec1.should eq(vzero)
    vec1.x = 42.0f32
    vec1.should_not eq(vzero)
    vec1.should eq(V4.new(42.0, 0.0, 0.0, 0.0))
    vec1.normalize.magnitude.should eq(1.0)
  end
end
