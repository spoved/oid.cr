require "../../spec_helper"

describe Oid::IActor do
  describe "when initialized" do
    it "has name" do
      actor = CustomActor.new("My Actor")
      actor.should be_a Oid::IActor
      actor.should be_a CustomActor
      actor.name.should eq "My Actor"
    end

    it "has transform" do
      actor = CustomActor.new("My Actor")
      actor.transform.should be_a Oid::Transform
      actor.transform.actor.should be actor
    end
  end
end
