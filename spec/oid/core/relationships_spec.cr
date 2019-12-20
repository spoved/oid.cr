require "../../spec_helper"

class RelTestObj
  include Oid::Relationships(RelTestObj)
end

private def orphan
  RelTestObj.new
end

private def subject
  parent = RelTestObj.new
  child = RelTestObj.new
  parent.add_child(child)
  {parent, child}
end

private def subject_tree
  parent = RelTestObj.new
  child = RelTestObj.new
  g_child1 = RelTestObj.new
  g_child2 = RelTestObj.new
  gg_child = RelTestObj.new

  parent.add_child(child)
  child.add_child(g_child1)
  child.add_child(g_child2)
  g_child1.add_child(gg_child)
  {parent, child, g_child1, g_child2, gg_child}
end

describe Oid::Relationships do
  it "#relationship" do
    parent, child = subject
    parent.relationship_to(child).should eq :parent
    child.relationship_to(parent).should eq :child
    parent.relationship_to(orphan).should eq :none
    child.relationship_to(orphan).should eq :none
  end

  describe "no parent" do
    it "raises error" do
      child = RelTestObj.new
      expect_raises(Exception, "No parent exists! Please check if parent exists before trying to fech parent") do
        child.parent
      end
    end
  end

  describe "parent" do
    # it "can be set" do
    #   parent = RelTestObj.new
    #   child = RelTestObj.new

    #   child.parent?.should be_false
    #   child._parent parent
    #   child.parent.should be parent
    # end

    it "presence can be checked" do
      parent = RelTestObj.new
      child = RelTestObj.new

      child.parent?.should be_falsey
      parent.add_child child
      child.parent?.should be_truthy
    end

    describe "when removed" do
      it "parent is nil" do
        parent, child = subject

        child.parent.should be parent
        child.clear_parent!
        child.parent?.should be_false
      end

      it "removes self from parent" do
        parent, child = subject

        parent.has_child?(child).should be_true
        child.has_parent?(parent).should be_true
        child.related?(parent).should be_true

        child.clear_parent!

        parent.has_child?(child).should be_false
        child.has_parent?(parent).should be_false
        child.related?(parent).should be_false
      end
    end

    describe "forward relationship" do
      it "can be checked" do
        parent, child = subject
        child.has_parent?(parent).should be_true
        child.has_parent?(orphan).should be_false
      end
    end

    describe "reverse relationship" do
      it "can be checked" do
        parent, child = subject
        parent.has_child?(child).should be_true
        parent.has_child?(orphan).should be_false
      end
    end

    describe "ancestory" do
      it "can be checked" do
        parent, child, g_child1, g_child2, gg_child = subject_tree

        parent.parent_of?(parent).should be_true
        parent.parent_of?(child).should be_true
        parent.parent_of?(g_child1).should be_true
        parent.parent_of?(g_child2).should be_true
        parent.parent_of?(gg_child).should be_true
        parent.parent_of?(orphan).should be_false

        child.parent_of?(parent).should be_false
        child.parent_of?(child).should be_true
        child.parent_of?(g_child1).should be_true
        child.parent_of?(g_child2).should be_true
        child.parent_of?(gg_child).should be_true
        child.parent_of?(orphan).should be_false

        g_child1.parent_of?(parent).should be_false
        g_child1.parent_of?(child).should be_false
        g_child1.parent_of?(g_child1).should be_true
        g_child1.parent_of?(g_child2).should be_false
        g_child1.parent_of?(gg_child).should be_true
        g_child1.parent_of?(orphan).should be_false

        g_child2.parent_of?(parent).should be_false
        g_child2.parent_of?(child).should be_false
        g_child2.parent_of?(g_child1).should be_false
        g_child2.parent_of?(g_child2).should be_true
        g_child2.parent_of?(gg_child).should be_false
        g_child2.parent_of?(orphan).should be_false

        gg_child.parent_of?(parent).should be_false
        gg_child.parent_of?(child).should be_false
        gg_child.parent_of?(g_child1).should be_false
        gg_child.parent_of?(g_child2).should be_false
        gg_child.parent_of?(gg_child).should be_true
        gg_child.parent_of?(orphan).should be_false
      end
    end
  end

  describe "children" do
    it "can be set" do
      parent, child = subject
      parent.children_count.should eq 1
    end

    it "presence can be checked" do
      parent, child = subject
      parent.children?.should be_true
    end

    describe "forward relationship" do
      it "can be checked" do
        parent, child = subject
        parent.has_child?(child).should be_true
        parent.has_child?(orphan).should be_false
      end
    end

    describe "reverse relationship" do
      it "can be checked" do
        parent, child = subject
        child.has_parent?(parent).should be_true
        child.has_parent?(orphan).should be_false
      end
    end

    describe "ancestory" do
      it "can be checked" do
        parent, child, g_child1, g_child2, gg_child = subject_tree

        child.children_count.should eq 2

        parent.child_of?(parent).should be_true
        parent.child_of?(child).should be_false
        parent.child_of?(g_child1).should be_false
        parent.child_of?(g_child2).should be_false
        parent.child_of?(gg_child).should be_false
        parent.child_of?(orphan).should be_false

        g_child1.child_of?(parent).should be_true
        g_child1.child_of?(child).should be_true
        g_child1.child_of?(g_child1).should be_true
        g_child1.child_of?(g_child2).should be_false
        g_child1.child_of?(gg_child).should be_false
        g_child1.child_of?(orphan).should be_false

        g_child2.child_of?(parent).should be_true
        g_child2.child_of?(child).should be_true
        g_child2.child_of?(g_child1).should be_false
        g_child2.child_of?(g_child2).should be_true
        g_child2.child_of?(gg_child).should be_false
        g_child2.child_of?(orphan).should be_false

        gg_child.child_of?(parent).should be_true
        gg_child.child_of?(child).should be_true
        gg_child.child_of?(g_child1).should be_true
        gg_child.child_of?(g_child2).should be_false
        gg_child.child_of?(gg_child).should be_true
        gg_child.child_of?(orphan).should be_false
      end

      it "#root" do
        parent, child, g_child1, g_child2, gg_child = subject_tree

        parent.root.should be parent
        child.root.should be parent
        g_child1.root.should be parent
        g_child2.root.should be parent
        gg_child.root.should be parent

        orp = orphan
        orp.root.should be orp
      end
    end
  end
end
