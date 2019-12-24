require "../../spec_helper"

private def create_root_view(position)
  controller = new_spec_controller
  controller.start
  controller.contexts.stage.root_view?.should be_true
  controller.contexts.stage.root_view_entity.replace_position(position)
  controller.contexts.stage.root_view_entity.position.value.should eq position
  controller.update
  controller
end

describe Oid::Transformable do
  describe "2D" do
    describe "with root at 0, 0" do
      describe Oid::Enum::Position::Relative do
        controller = create_root_view(Oid::Vector3.zero)

        position = Oid::Vector3.new(10.0, 100.0, 10.0)
        entity = controller.contexts.stage.create_entity
          .add_position(position)
          .add_position_type(Oid::Enum::Position::Relative)
        entity.parent?.should be_true

        it "transforms position to root" do
          entity.parent.should be controller.contexts.stage.root_view_entity
          entity.transform.should eq position
        end

        it "transforms position relative to parent" do
          pos2 = Oid::Vector3.new(10.0, 2.0, 200.0)
          entity2 = controller.contexts.stage.create_entity
            .add_position(pos2)
            .add_position_type(Oid::Enum::Position::Relative)
          entity.add_child(entity2)
          entity2.transform.should_not eq position
          entity2.transform.should eq (position + pos2)

          pos3 = Oid::Vector3.new(1000.0, -89.0, 20.0)
          entity3 = controller.contexts.stage.create_entity
            .add_position(pos3)
            .add_position_type(Oid::Enum::Position::Relative)
          entity2.add_child(entity3)
          entity3.transform.should_not eq position
          entity3.transform.should eq (position + pos2 + pos3)
        end
      end

      describe Oid::Enum::Position::Absolute do
        controller = create_root_view(Oid::Vector3.zero)

        position = Oid::Vector3.new(10.0, 100.0, 10.0)
        entity = controller.contexts.stage.create_entity
          .add_position(position)
          .add_position_type(Oid::Enum::Position::Absolute)
        entity.parent?.should be_true

        it "transforms position to root" do
          entity.parent.should be controller.contexts.stage.root_view_entity
          entity.transform.should eq position
        end

        it "transforms position absolutly to parent" do
          pos2 = Oid::Vector3.new(10.0, 2.0, 200.0)
          entity2 = controller.contexts.stage.create_entity
            .add_position(pos2)
            .add_position_type(Oid::Enum::Position::Absolute)
          entity.add_child(entity2)
          entity2.transform.should_not eq position
          entity2.transform.should eq (pos2)

          pos3 = Oid::Vector3.new(1000.0, -89.0, 20.0)
          entity3 = controller.contexts.stage.create_entity
            .add_position(pos3)
            .add_position_type(Oid::Enum::Position::Absolute)
          entity2.add_child(entity3)
          entity3.transform.should_not eq position
          entity3.transform.should eq (pos3)
        end
      end

      describe Oid::Enum::Position::Static do
        it "does not transform position" do
          controller = create_root_view(Oid::Vector3.zero)

          position = Oid::Vector3.new(10.0, 100.0, 10.0)
          entity = controller.contexts.stage.create_entity
            .add_position(position)
            .add_position_type(Oid::Enum::Position::Static)
          entity.parent?.should be_true

          entity.parent.should be controller.contexts.stage.root_view_entity
          entity.transform.should eq position

          pos2 = Oid::Vector3.new(10.0, 2.0, 200.0)
          entity2 = controller.contexts.stage.create_entity
            .add_position(pos2)
            .add_position_type(Oid::Enum::Position::Static)
          entity.add_child(entity2)
          entity2.transform.should_not eq position
          entity2.transform.should eq (pos2)

          pos3 = Oid::Vector3.new(1000.0, -89.0, 20.0)
          entity3 = controller.contexts.stage.create_entity
            .add_position(pos3)
            .add_position_type(Oid::Enum::Position::Static)
          entity2.add_child(entity3)
          entity3.transform.should_not eq position
          entity3.transform.should eq (pos3)
        end
      end
    end

    describe "with root not at 0, 0" do
      describe Oid::Enum::Position::Relative do
        root_pos = Oid::Vector3.new(10.0, 10.0, 10.0)
        controller = create_root_view(root_pos)

        position = Oid::Vector3.new(10.0, 100.0, 10.0)
        entity = controller.contexts.stage.create_entity
          .add_position(position)
          .add_position_type(Oid::Enum::Position::Relative)
        entity.parent?.should be_true

        it "transforms position to root" do
          entity.parent.should be controller.contexts.stage.root_view_entity
          entity.transform.should eq (root_pos + position)
        end

        it "transforms position relative to parent" do
          pos2 = Oid::Vector3.new(10.0, 2.0, 200.0)
          entity2 = controller.contexts.stage.create_entity
            .add_position(pos2)
            .add_position_type(Oid::Enum::Position::Relative)
          entity.add_child(entity2)
          entity2.transform.should_not eq position
          entity2.transform.should eq (root_pos + position + pos2)

          pos3 = Oid::Vector3.new(1000.0, -89.0, 20.0)
          entity3 = controller.contexts.stage.create_entity
            .add_position(pos3)
            .add_position_type(Oid::Enum::Position::Relative)
          entity2.add_child(entity3)
          entity3.transform.should_not eq position
          entity3.transform.should eq (root_pos + position + pos2 + pos3)
        end
      end

      describe Oid::Enum::Position::Absolute do
        root_pos = Oid::Vector3.new(10.0, 10.0, 10.0)
        controller = create_root_view(root_pos)

        position = Oid::Vector3.new(10.0, 100.0, 10.0)
        entity = controller.contexts.stage.create_entity
          .add_position(position)
          .add_position_type(Oid::Enum::Position::Absolute)
        entity.parent?.should be_true

        it "transforms position to root" do
          entity.parent.should be controller.contexts.stage.root_view_entity
          entity.transform.should eq (root_pos + position)
        end

        it "transforms position absolutly to parent" do
          pos2 = Oid::Vector3.new(10.0, 2.0, 200.0)
          entity2 = controller.contexts.stage.create_entity
            .add_position(pos2)
            .add_position_type(Oid::Enum::Position::Absolute)
          entity.add_child(entity2)
          entity2.transform.should_not eq position
          entity2.transform.should eq (root_pos + pos2)

          pos3 = Oid::Vector3.new(1000.0, -89.0, 20.0)
          entity3 = controller.contexts.stage.create_entity
            .add_position(pos3)
            .add_position_type(Oid::Enum::Position::Absolute)
          entity2.add_child(entity3)
          entity3.transform.should_not eq position
          entity3.transform.should eq (root_pos + pos3)
        end
      end

      describe Oid::Enum::Position::Static do
        it "does not transform position" do
          root_pos = Oid::Vector3.new(10.0, 10.0, 10.0)
          controller = create_root_view(root_pos)

          position = Oid::Vector3.new(10.0, 100.0, 10.0)
          entity = controller.contexts.stage.create_entity
            .add_position(position)
            .add_position_type(Oid::Enum::Position::Static)
          entity.parent?.should be_true

          entity.parent.should be controller.contexts.stage.root_view_entity
          entity.transform.should eq position

          pos2 = Oid::Vector3.new(10.0, 2.0, 200.0)
          entity2 = controller.contexts.stage.create_entity
            .add_position(pos2)
            .add_position_type(Oid::Enum::Position::Static)
          entity.add_child(entity2)
          entity2.transform.should_not eq position
          entity2.transform.should eq (pos2)

          pos3 = Oid::Vector3.new(1000.0, -89.0, 20.0)
          entity3 = controller.contexts.stage.create_entity
            .add_position(pos3)
            .add_position_type(Oid::Enum::Position::Static)
          entity2.add_child(entity3)
          entity3.transform.should_not eq position
          entity3.transform.should eq (pos3)
        end
      end
    end
  end
end
