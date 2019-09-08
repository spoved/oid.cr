module Oid
  # Position, rotation and scale of an object.
  class Transform
    getter actor : Oid::Actor

    property position : RayLib::Vector3 = RayLib::Vector3.zero
    property rotation : RayLib::Quaternion = RayLib::Quaternion.zero

    def initialize(@actor : Oid::Actor); end

    def position=(value : RayLib::Vector2)
      self.position = value.to_v3
    end

    property parent : Transform? = nil
    property children : Set(Transform) = Set(Transform).new

    def set_parent(parent : Transform)
      @parent = parent
      parent.children.add(self)
    end

    # Is this transform a child of parent?
    #
    # Returns a boolean value that indicates whether the transform is a child of a given transform.
    # true if this transform is a child, deep child (child of a child) or identical to this transform,
    # otherwise false.
    def child_of?(parent : Transform)
      return true if parent.children.includes?(self)

      # TODO: Fix this? Add recursive search
      # parent.children.each do |child|
      #   return true if child.child_of?(self)
      # end
    end
  end
end
