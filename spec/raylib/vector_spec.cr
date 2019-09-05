require "../spec_helper"

describe RayLib::Binding::Vector2 do
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

    puts vect.to_unsafe
  end
end
