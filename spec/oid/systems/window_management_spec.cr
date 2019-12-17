require "../../spec_helper"

describe Oid::Systems::WindowMangement do
  it "creates initial window" do
    controller = new_spec_controller
    controller.start

    controller.contexts.app.window?.should be_true
  end

  it "destroy_window is called" do
    controller = new_spec_controller
    controller.start

    controller.contexts.app.window?.should be_true
    controller.contexts.app.window_entity.destroyed = true

    controller.update

    controller.contexts.app.window?.should be_false
  end
end
