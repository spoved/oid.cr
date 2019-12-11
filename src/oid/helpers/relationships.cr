module Oid
  module Helpers
    module Relationships(T)
      @parent : T? = nil
      private getter children : Set(T) = Set(T).new

      def parent : T
        if @parent.nil?
          raise "No parent exists! Please check if parent exists before trying to fech parent"
        end

        @parent.as(T)
      end

      # Returns the total count of children
      def children_count
        self.children.size
      end

      # Check if parent is set
      def parent? : Bool
        !self.parent.nil?
      end

      # Check if children are present
      def children? : Bool
        !self.children.empty?
      end

      def get_child(kind)
        self.children.select { |c| c.class == kind }
      end

      # :nodoc:
      # Internal method to set parent
      private def set_parent(parent : T?)
        @parent = parent
      end

      # Yields each `T` child to provided block
      def each_child(&block : T -> Nil)
        self.children.each do |child|
          yield child
        end
      end

      def related?(other : T)
        (self.child_of?(other) || self.parent_of?(other))
      end

      # Will return a symbol of the relationship of `self` to `other`.
      # Will return `:parent` if `other` is a child of self.
      # Will return `:child` if `other` is a parent of self.
      # Will return `:none` if there is no relationship.
      #
      # ```
      # class RelTestObj
      #   include Oid::Helpers::Relationships(RelTestObj)
      # end
      #
      # parent = RelTestObj.new
      # child = RelTestObj.new
      # orphan = RelTestObj.new
      #
      # parent.add_child(child)
      #
      # parent.relationship_to(child)  # => :parent
      # child.relationship_to(parent)  # => :child
      # parent.relationship_to(orphan) # => :none
      # child.relationship_to(orphan)  # => :none
      # ```
      def relationship_to(other : T)
        case other
        when .child_of?(self)
          :parent
        when .parent_of?(self)
          :child
        else
          :none
        end
      end

      # Is this object a child of parent?
      #
      # Returns a `Bool` value that indicates whether the object is a child of a given object.
      # true if this object is a child, deep child (child of a child) or identical to `self`,
      # otherwise false.
      def child_of?(parent : T) : Bool
        if self === parent || parent.has_child?(self)
          true
        else
          parent.each_child do |child|
            if child === self || child.has_child?(self) || self.child_of?(child)
              return true
            end
          end

          false
        end
      end

      # Is this object a parent of child?
      #
      # Returns a `Bool` value that indicates whether the object is a parent of a given object.
      # true if this object is a parent, deep parent (parent of a parent) or identical to `self`,
      # otherwise false.
      def parent_of?(child : T) : Bool
        if self === child || child.has_parent?(self)
          true
        else
          ancestor = child.parent
          if !ancestor.nil? && self.parent_of?(ancestor)
            return true
          end
          false
        end
      end

      # Returns the top-most parent of the objects relationships
      def root : T
        if self.parent?
          self.parent.as(T).root
        else
          self
        end
      end

      # Returns a `Bool` value that indicates whether the object is a direct child of `self`.
      def has_child?(child : T) : Bool
        self.children.includes?(child)
      end

      # Returns a `Bool` value that indicates whether the object is a direct parent of `self`.
      def has_parent?(parent : T) : Bool
        self.parent == parent
      end

      # Set the parent
      def parent=(parent : T)
        self.set_parent(parent)
      end

      # Add provided object as a child and set `self` as parent to object
      def add_child(child : T)
        child.parent = self
        self.children.add(child)
      end

      # Removes parent from `self`
      def clear_parent!
        old_parent = self.parent
        if !old_parent.nil? && old_parent.has_child?(self)
          old_parent.delete_child(self)
        end

        self.set_parent nil
      end

      # Removes child from `self`
      def delete_child(child : T)
        self.children.delete(child)

        if child.parent?
          child.clear_parent!
        end
      end
    end
  end
end
