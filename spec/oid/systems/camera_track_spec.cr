require "../../spec_helper"

describe Oid::Systems::CameraTrack do
  it "should track target" do
    controller = new_spec_controller
    controller.start

    camera = controller.contexts.stage
      .create_entity
      .add_camera

    controller.update

    camera.position?.should be_false

    target = controller.contexts.stage
      .create_entity
      .add_camera_target
      .add_position(Oid::Vector3.zero)

    controller.update

    camera.position?.should be_true

    5.times do
      target.replace_position(Oid::Vector3.new(Random.rand, Random.rand, Random.rand))
      controller.update

      camera.position?.should be_true
      camera.position.value.should eq target.position.value
    end
  end
end
