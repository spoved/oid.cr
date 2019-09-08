require "../../spec_helper"

private def new_trans
  actor = CustomActor.new("name")
  actor.transform
end

describe Oid::Transform do
  describe "when initialized" do
    it "has a zero position" do
      trans = new_trans
      trans.position.should eq RayLib::Vector3.zero
    end

    it "has a zero rotation" do
      trans = new_trans
      trans.rotation.should eq RayLib::Quaternion.zero
    end

    it "has an actor" do
      trans = new_trans
      trans.actor.should be_a Oid::IActor
    end
  end

  describe "relationships" do
    it "can be set" do
      trans1 = new_trans
      trans2 = new_trans

      trans1.add_child(trans2)
      trans1.has_child?(trans2).should be_true
      trans2.has_parent?(trans1).should be_true
    end
  end
end
