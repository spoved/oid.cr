require "../../spec_helper"

describe Oid::Systems::Move do
  it "moves entity" do
    controller = new_spec_controller
    controller.start

    entity = controller.contexts.stage
      .create_entity
      .add_position(Oid::Vector3.zero)
      .add_move(
        target: Oid::Vector3.new(100.0, 100.0, 0.0),
        speed: 1.0
      )

    controller.update

    pos = entity.position.value
    pos.x.should be_close(70.7, 0.1)
    pos.y.should be_close(70.7, 0.1)

    controller.update

    pos = entity.position.value
    pos.x.should eq 100.0
    pos.y.should eq 100.0

    entity.move?.should be_false
  end
end
