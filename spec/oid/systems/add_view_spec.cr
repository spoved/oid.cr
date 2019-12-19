require "../../spec_helper"

describe Oid::Systems::AddView do
  it "adds a view to the entity" do
    controller = new_spec_controller
    controller.start

    entity = controller.contexts.stage.create_entity
      .add_asset(
        name: "asset_01",
        type: Oid::Enum::AssetType::Image
      )
    entity.view?.should be_false
    entity.asset_loaded?.should be_false

    controller.update

    entity.view?.should be_truthy
    entity.asset_loaded?.should be_truthy

    entity.view.value.should be_a Oid::Controller::View
  end
end
