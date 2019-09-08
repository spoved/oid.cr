require "./actor"
require "../helpers/relationships"

module Oid
  # Position, rotation and scale of an object.
  class Transform
    include Oid::Helpers::Relationships(Transform)

    getter actor : Oid::IActor? = nil

    property position : RayLib::Vector3 = RayLib::Vector3.zero
    property rotation : RayLib::Quaternion = RayLib::Quaternion.zero

    def initialize; end

    def initialize(@actor : Oid::IActor); end

    def position=(value : RayLib::Vector2)
      self.position = value.to_v3
    end
  end
end
