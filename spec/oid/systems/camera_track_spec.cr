require "../../spec_helper"

describe Oid::Systems::Camera do
  it "should track target" do
    controller = new_spec_controller
    controller.start

    controller.contexts.stage.camera?.should be_true
    camera = controller.contexts.stage.camera_entity

    controller.update

    target = controller.contexts.stage
      .create_entity
      .add_camera_target
      .add_position(Oid::Vector3.zero)

    controller.update

    5.times do
      target.replace_position(
        Oid::Vector3.new(Random.rand, Random.rand, Random.rand)
      )
      controller.update
      camera.camera.target.should eq target.position.value
    end
  end
end
