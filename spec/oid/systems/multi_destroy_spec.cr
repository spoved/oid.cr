require "../../spec_helper"

describe Oid::Systems::MultiDestroy do
  it "destoys entities in multiple contexts" do
    controller = new_spec_controller
    controller.start

    stage_entity = controller.contexts.stage.create_entity
    input_entity = controller.contexts.input.create_entity

    stage_entity_destroyed = false
    stage_entity.on_destroy_entity do |_|
      stage_entity_destroyed = true
    end

    input_entity_destroyed = false
    input_entity.on_destroy_entity do |_|
      input_entity_destroyed = true
    end

    controller.update

    stage_entity_destroyed.should be_false
    input_entity_destroyed.should be_false

    stage_entity.add_destroyed
    input_entity.add_destroyed

    controller.update

    stage_entity_destroyed.should be_true
    input_entity_destroyed.should be_true
  end
end
