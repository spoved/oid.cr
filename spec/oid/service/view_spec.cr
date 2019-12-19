require "../../spec_helper"

describe Oid::Service::View do
  it "adds a view to the entity" do
    controller = new_spec_controller
    controller.start

    service = controller.services.view
    service.should be_a Oid::Service::View

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

    view = entity.view.value
    view.should be_a Oid::Controller::View

    entity.add_destroyed

    controller.update

    view.destroy_view_was_called.should be_true
  end
end
