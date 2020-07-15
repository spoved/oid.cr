require "../../spec_helper"

private def bound_entity(position_type, origin, scale = 1.0)
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
    .add_scale(scale)
    .add_collidable
  controller.update

  {entity, controller}
end

private def bound_asset_entity(position_type, origin, scale = 1.0)
  controller = new_spec_controller
  controller.start
  entity = controller.contexts.stage.create_entity
    .add_position(Oid::Vector3.zero)
    .add_position_type(position_type)
    .add_scale(scale)
    .add_asset(
      name: "asset_01",
      type: Oid::Enum::AssetType::Image,
      origin: origin,
    )
    .add_collidable
  controller.update

  {entity, controller}
end

describe Oid::CollisionFuncs do
  describe "#collision_rec" do
    describe "calculates the collision rec" do
      it "two rectagles" do
        entity1, controller = bound_entity(Oid::Enum::Position::Static, Oid::Vector3.zero)

        entity2 = controller.contexts.stage.create_entity
          .add_position(Oid::Vector3.new(10.0, 10.0, 0.0))
          .add_position_type(Oid::Enum::Position::Static)
          .add_view_element(
            value: Oid::Element::Rectangle.new(
              width: 20.0,
              height: 20.0,
              color: Oid::Color::GREEN
            ),
            origin: Oid::Vector3.zero
          )
          .add_collidable

        controller.update

        Oid::CollisionFuncs.collision_recs?(entity1, entity2).should be_true

        rec = Oid::CollisionFuncs.collision_rec(entity1, entity2)

        rec[:x].should eq 10.0
        rec[:y].should eq 10.0
        rec[:width].should eq 10.0
        rec[:height].should eq 10.0
      end

      it "two assets" do
        entity1, controller = bound_asset_entity(Oid::Enum::Position::Static, Oid::Vector3.zero)

        entity2, _ = bound_asset_entity(Oid::Enum::Position::Static, Oid::Vector3.zero, 0.5)
        entity2.replace_position(Oid::Vector3.new(10.0, 10.0, 0.0))

        controller.update

        Oid::CollisionFuncs.collision_recs?(entity1, entity2).should be_true

        rec = Oid::CollisionFuncs.collision_rec(entity1, entity2)

        rec[:x].should eq 10.0
        rec[:y].should eq 10.0
        rec[:width].should eq 64.0
        rec[:height].should eq 64.0
      end

      it "asset and rec" do
        entity1, controller = bound_asset_entity(Oid::Enum::Position::Static, Oid::Vector3.zero)
        entity2, _ = bound_entity(Oid::Enum::Position::Static, Oid::Vector3.zero, 0.5)

        controller.update

        Oid::CollisionFuncs.collision_recs?(entity1, entity2).should be_true

        rec = Oid::CollisionFuncs.collision_rec(entity1, entity2)

        rec[:x].should eq 0.0
        rec[:y].should eq 0.0
        rec[:width].should eq 10.0
        rec[:height].should eq 10.0
      end
    end
  end

  describe "#calc_rec_origin" do
    describe Oid::Enum::OriginType::UpperLeft do
      it "should calculate correct origin" do
        Oid::CollisionFuncs.calc_rec_origin(
          Oid::Enum::OriginType::UpperLeft,
          width: 100,
          height: 100,
        ).should eq Oid::Vector2.new(
          x: 0.0,
          y: 0.0,
        )
      end
    end

    describe Oid::Enum::OriginType::UpperCenter do
      it "should calculate correct origin" do
        Oid::CollisionFuncs.calc_rec_origin(
          Oid::Enum::OriginType::UpperCenter,
          width: 100,
          height: 100,
        ).should eq Oid::Vector2.new(
          x: 50.0,
          y: 0.0,
        )
      end
    end

    describe Oid::Enum::OriginType::UpperRight do
      it "should calculate correct origin" do
        Oid::CollisionFuncs.calc_rec_origin(
          Oid::Enum::OriginType::UpperRight,
          width: 100,
          height: 100,
        ).should eq Oid::Vector2.new(
          x: 100.0,
          y: 0.0,
        )
      end
    end

    describe Oid::Enum::OriginType::CenterLeft do
      it "should calculate correct origin" do
        Oid::CollisionFuncs.calc_rec_origin(
          Oid::Enum::OriginType::CenterLeft,
          width: 100,
          height: 100,
        ).should eq Oid::Vector2.new(
          x: 0.0,
          y: 50.0,
        )
      end
    end

    describe Oid::Enum::OriginType::Center do
      it "should calculate correct origin" do
        Oid::CollisionFuncs.calc_rec_origin(
          Oid::Enum::OriginType::Center,
          width: 100,
          height: 100,
        ).should eq Oid::Vector2.new(
          x: 50.0,
          y: 50.0,
        )
      end
    end

    describe Oid::Enum::OriginType::CenterRight do
      it "should calculate correct origin" do
        Oid::CollisionFuncs.calc_rec_origin(
          Oid::Enum::OriginType::CenterRight,
          width: 100,
          height: 100,
        ).should eq Oid::Vector2.new(
          x: 100.0,
          y: 50.0,
        )
      end
    end

    describe Oid::Enum::OriginType::BottomLeft do
      it "should calculate correct origin" do
        Oid::CollisionFuncs.calc_rec_origin(
          Oid::Enum::OriginType::BottomLeft,
          width: 100,
          height: 100,
        ).should eq Oid::Vector2.new(
          x: 0.0,
          y: 100.0,
        )
      end
    end

    describe Oid::Enum::OriginType::BottomCenter do
      it "should calculate correct origin" do
        Oid::CollisionFuncs.calc_rec_origin(
          Oid::Enum::OriginType::BottomCenter,
          width: 100,
          height: 100,
        ).should eq Oid::Vector2.new(
          x: 50.0,
          y: 100.0,
        )
      end
    end

    describe Oid::Enum::OriginType::BottomRight do
      it "should calculate correct origin" do
        Oid::CollisionFuncs.calc_rec_origin(
          Oid::Enum::OriginType::BottomRight,
          width: 100,
          height: 100,
        ).should eq Oid::Vector2.new(
          x: 100.0,
          y: 100.0,
        )
      end
    end
  end

  describe "#bounding_box_for_element" do
    describe "with scale" do
      it "should calculate correct bounding box" do
        entity, _ = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::UpperLeft, 2.0)
        bounds_rect = Oid::CollisionFuncs.bounding_box_for_element(entity)

        expected = Oid::Element::BoundingBox.new(
          min: Oid::Vector3.new(
            x: 0.0,
            y: 0.0,
            z: 0.0,
          ),
          max: Oid::Vector3.new(
            x: 40.0,
            y: 40.0,
            z: 0.0,
          )
        )

        bounds_rect.should eq expected
      end
    end

    describe Oid::Enum::Position::Static do
      describe Oid::Enum::OriginType::UpperLeft do
        it "should calculate correct bounding box" do
          entity, _ = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::UpperLeft)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_element(entity)

          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: 0.0,
              y: 0.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 20.0,
              y: 20.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end

      describe Oid::Enum::OriginType::UpperCenter do
        it "should calculate correct bounding box" do
          entity, _ = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::UpperCenter)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_element(entity)
          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: -10.0,
              y: 0.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 10.0,
              y: 20.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end

      describe Oid::Enum::OriginType::UpperRight do
        it "should calculate correct bounding box" do
          entity, _ = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::UpperRight)
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

      describe Oid::Enum::OriginType::CenterLeft do
        it "should calculate correct bounding box" do
          entity, _ = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::CenterLeft)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_element(entity)
          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: 0.0,
              y: -10.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 20.0,
              y: 10.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end

      describe Oid::Enum::OriginType::Center do
        it "should calculate correct bounding box" do
          entity, _ = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::Center)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_element(entity)
          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: -10.0,
              y: -10.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 10.0,
              y: 10.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end

      describe Oid::Enum::OriginType::CenterRight do
        it "should calculate correct bounding box" do
          entity, _ = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::CenterRight)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_element(entity)
          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: -20.0,
              y: -10.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 0.0,
              y: 10.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end

      describe Oid::Enum::OriginType::BottomLeft do
        it "should calculate correct bounding box" do
          entity, _ = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::BottomLeft)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_element(entity)
          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: 0.0,
              y: -20.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 20.0,
              y: 0.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end

      describe Oid::Enum::OriginType::BottomCenter do
        it "should calculate correct bounding box" do
          entity, _ = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::BottomCenter)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_element(entity)
          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: -10.0,
              y: -20.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 10.0,
              y: 0.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end

      describe Oid::Enum::OriginType::BottomRight do
        it "should calculate correct bounding box" do
          entity, _ = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::BottomRight)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_element(entity)
          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: -20.0,
              y: -20.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 0.0,
              y: 0.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end
    end

    describe Oid::Enum::Position::Relative do
      describe Oid::Enum::OriginType::UpperLeft do
        it "should calculate correct bounding box" do
          entity, _ = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::UpperLeft)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_element(entity)
          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: 0.0,
              y: 0.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 20.0,
              y: 20.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end
    end
  end

  describe "#bounding_box_for_asset" do
    describe "with scale" do
      it "should calculate correct bounding box" do
        entity, _ = bound_asset_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::UpperLeft, 0.5)

        bounds_rect = Oid::CollisionFuncs.bounding_box_for_asset(entity, 20, 20)

        expected = Oid::Element::BoundingBox.new(
          min: Oid::Vector3.new(
            x: 0.0,
            y: 0.0,
            z: 0.0,
          ),
          max: Oid::Vector3.new(
            x: 10.0,
            y: 10.0,
            z: 0.0,
          )
        )

        bounds_rect.should eq expected
      end
    end

    describe Oid::Enum::Position::Static do
      describe Oid::Enum::OriginType::UpperLeft do
        it "should calculate correct bounding box" do
          entity, _ = bound_asset_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::UpperLeft)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_asset(entity, 20, 20)

          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: 0.0,
              y: 0.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 20.0,
              y: 20.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end

      describe Oid::Enum::OriginType::UpperCenter do
        it "should calculate correct bounding box" do
          entity, _ = bound_asset_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::UpperCenter)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_asset(entity, 20, 20)
          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: -10.0,
              y: 0.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 10.0,
              y: 20.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end

      describe Oid::Enum::OriginType::UpperRight do
        it "should calculate correct bounding box" do
          entity, _ = bound_asset_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::UpperRight)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_asset(entity, 20, 20)
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

      describe Oid::Enum::OriginType::CenterLeft do
        it "should calculate correct bounding box" do
          entity, _ = bound_asset_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::CenterLeft)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_asset(entity, 20, 20)
          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: 0.0,
              y: -10.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 20.0,
              y: 10.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end

      describe Oid::Enum::OriginType::Center do
        it "should calculate correct bounding box" do
          entity, _ = bound_asset_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::Center)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_asset(entity, 20, 20)
          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: -10.0,
              y: -10.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 10.0,
              y: 10.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end

      describe Oid::Enum::OriginType::CenterRight do
        it "should calculate correct bounding box" do
          entity, _ = bound_asset_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::CenterRight)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_asset(entity, 20, 20)
          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: -20.0,
              y: -10.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 0.0,
              y: 10.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end

      describe Oid::Enum::OriginType::BottomLeft do
        it "should calculate correct bounding box" do
          entity, _ = bound_asset_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::BottomLeft)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_asset(entity, 20, 20)
          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: 0.0,
              y: -20.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 20.0,
              y: 0.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end

      describe Oid::Enum::OriginType::BottomCenter do
        it "should calculate correct bounding box" do
          entity, _ = bound_asset_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::BottomCenter)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_asset(entity, 20, 20)
          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: -10.0,
              y: -20.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 10.0,
              y: 0.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end

      describe Oid::Enum::OriginType::BottomRight do
        it "should calculate correct bounding box" do
          entity, _ = bound_asset_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::BottomRight)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_asset(entity, 20, 20)
          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: -20.0,
              y: -20.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 0.0,
              y: 0.0,
              z: 0.0,
            )
          )

          bounds_rect.should eq expected
        end
      end
    end

    describe Oid::Enum::Position::Relative do
      describe Oid::Enum::OriginType::UpperLeft do
        it "should calculate correct bounding box" do
          entity, _ = bound_asset_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::UpperLeft)
          bounds_rect = Oid::CollisionFuncs.bounding_box_for_asset(entity, 20, 20)
          expected = Oid::Element::BoundingBox.new(
            min: Oid::Vector3.new(
              x: 0.0,
              y: 0.0,
              z: 0.0,
            ),
            max: Oid::Vector3.new(
              x: 20.0,
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
