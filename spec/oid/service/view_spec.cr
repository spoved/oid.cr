require "../../spec_helper"

private def create_entity
  controller = new_spec_controller
  controller.start
  service = controller.services.view
  service.should be_a Oid::Service::View
  entity = controller.contexts.stage.create_entity
  {controller, entity}
end

private def get_view(controller, entity)
  controller.update
  entity.view?.should be_truthy
  entity.asset_loaded?.should be_truthy

  view = entity.view.value
  view.should be_a Oid::Controller::View
  view
end

private def cleanup(controller, entity)
  entity.add_destroyed
  controller.update
end

describe Oid::Service::View do
  it "adds a view to the entity" do
    controller, entity = create_entity

    entity.add_asset(
      name: "asset_01",
      type: Oid::Enum::AssetType::Image
    )
    entity.view?.should be_false
    entity.asset_loaded?.should be_false

    view = get_view(controller, entity)

    cleanup(controller, entity)

    view.destroy_view_was_called.should be_true
  end

  describe "#bounding_box" do
    it "creates correct box" do
      controller, entity = create_entity

      entity.add_asset(
        name: "asset_01",
        type: Oid::Enum::AssetType::Image
      ).add_position(
        Oid::Vector3.new(0.0, 0.0, 0.0)
      ).add_position_type(
        Oid::Enum::Position::Static
      )

      expected = Oid::Element::BoundingBox.new(
        min: Oid::Vector3.new(
          x: 0.0,
          y: 0.0,
          z: 0.0,
        ),
        max: Oid::Vector3.new(
          x: 128.0,
          y: 128.0,
          z: 0.0,
        )
      )

      view = get_view(controller, entity)
      actual = view.bounding_box
      actual.should eq expected

      Oid::CollisionFuncs.bounding_box_for_entity(entity).should eq expected
      Oid::CollisionFuncs.bounding_box_for_entity(entity).should eq actual

      cleanup(controller, entity)
    end
  end
end
