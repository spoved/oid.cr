require "../../spec_helper"

describe Oid::Systems::RelationshipManager do
  describe "UiElement Entities" do
    it "sets ui_element on children" do
      controller = new_spec_controller
      controller.start
      entity = controller.contexts.stage.create_entity.add_ui_element

      entity.parent?.should be_true
      controller.update

      e2 = controller.contexts.stage.create_entity
      e2.ui_element?.should be_false
      entity.add_child e2
      e2.ui_element?.should be_true

      e3 = controller.contexts.stage.create_entity
      e3.ui_element?.should be_false
      e2.add_child e3
      e3.ui_element?.should be_true
    end

    it "sets ui_element on children recursively" do
      controller = new_spec_controller
      controller.start
      entity = controller.contexts.stage.create_entity.add_ui_element

      entity.parent?.should be_true
      controller.update

      childs = Array(Oid::RenderableEntity).new
      10.times do
        c = controller.contexts.stage.create_entity
        if childs.size != 0
          childs.last.add_child c
        end
        childs << c
      end

      childs.each do |c|
        c.ui_element?.should be_false
        c.parent?.should be_true
        c.parent.ui_element?.should be_false
      end

      entity.add_child childs.first
      childs.each do |c|
        c.parent?.should be_true
        c.parent.ui_element?.should be_true
        c.ui_element?.should be_true
      end
    end
  end
end
