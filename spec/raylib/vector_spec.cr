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

  it "can be converted to a Vector3" do
    vect = RayLib::Vector2.new(x: 10, y: 2)
    vect.should be_a RayLib::Vector2
    vect.to_v3.should be_a RayLib::Vector3
    vect.to_v3.z.should eq 0
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
