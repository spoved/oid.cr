require "../../spec_helper"

private def bound_entity(position_type, origin)
  controller = new_spec_controller
  controller.start
  entity = controller.contexts.stage.create_entity
    .add_position(Oid::Vector3.zero)
    .add_position_type(position_type)
    .add_view_element(
      value: Oid::Element::Rectangle.new(
        width: 20.0,
        height: 20.0,
        color: Oid::Color::GREEN
      ),
      origin: origin
    )
    .add_collidable
  controller.update
  {controller, entity}
end

describe Oid::CollidableEntity do
  describe "#bounds_rect" do
    describe "entity with Oid::Element::Rectangle" do
      describe "with position type Static" do
        describe "and orgin of UpperLeft" do
          # it "should calculate bounds" do
          #   controller, entity = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::UpperLeft)

          #   entity.view_element?.should be_true
          #   bounds_rect = entity.bounds_rect

          #   expected = Oid::Element::BoundingBox.new(
          #     min: Oid::Vector3.new(
          #       x: 0.0,
          #       y: 0.0,
          #       z: 0.0,
          #     ),
          #     max: Oid::Vector3.new(
          #       x: 20.0,
          #       y: 20.0,
          #       z: 0.0,
          #     )
          #   )

          #   bounds_rect.should eq expected
          # end
        end

        describe "and orgin of UpperRight" do
          it "should calculate bounds" do
            controller, entity = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::UpperRight)

            entity.view_element?.should be_true

            # puts entity.transform
            # puts Oid::CollisionFuncs.bounding_box_for_element(entity)
            bounds_rect = Oid::CollisionFuncs.bounding_box_for_element(entity)
            expected = Oid::Element::BoundingBox.new(
              min: Oid::Vector3.new(
                x: -20.0,
                y: 0.0,
                z: 0.0,
              ),
              max: Oid::Vector3.new(
                x: 0.0,
                y: 20.0,
                z: 0.0,
              )
            )

            bounds_rect.should eq expected
          end
        end
      end
    end
  end
end
