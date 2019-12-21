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
  entity
end

describe Oid::CollisionFuncs do
  describe "#collision_rec" do
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
    describe Oid::Enum::Position::Static do
      describe Oid::Enum::OriginType::UpperLeft do
        it "should calculate correct bounding box" do
          entity = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::UpperLeft)
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
          entity = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::UpperCenter)
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
          entity = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::UpperRight)
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
          entity = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::CenterLeft)
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
          entity = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::Center)
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
          entity = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::CenterRight)
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
          entity = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::BottomLeft)
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
          entity = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::BottomCenter)
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
          entity = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::BottomRight)
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
          entity = bound_entity(Oid::Enum::Position::Static, Oid::Enum::OriginType::UpperLeft)
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
end
