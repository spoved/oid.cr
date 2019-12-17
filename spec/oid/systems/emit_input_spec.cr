require "../../spec_helper"

describe Oid::Systems::EmitInput do
  it "should emit inputs" do
    controller = new_spec_controller
    controller.start

    controller.contexts.input.left_mouse_entity?.should_not be_nil
    controller.contexts.input.left_mouse_entity.position?.should be_false

    components_added = 0

    controller.contexts.input.left_mouse_entity.on_component_added do |_|
      components_added += 1
    end

    controller.update
    components_added.should eq 3
  end
end
