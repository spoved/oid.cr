require "../../helpers/relationships"
require "../../helpers/transformable"

module Oid
  module GameObject
    include JSON::Serializable
    include Oid::Transformable
    include Oid::Helpers::Relationships(Oid::Transformable)

    def add_object(child : Oid::GameObject,
                   positioning : Oid::Enum::Position = Oid::Enum::Position::Relative,
                   position : Oid::Vector3 = Oid::Vector3.zero,
                   rotation : Oid::Vector3 = Oid::Vector3.zero)
      child.positioning = positioning
      child.position = position
      child.rotation = rotation
      self.add_child(child)
    end

    def bounds_rect
      rects = get_child(Oid::Rectangle)
      size = rects.empty? ? Oid::Vector3.zero : Oid::Vector3.new(
        x: rects.first.as(Oid::Rectangle).width,
        y: rects.first.as(Oid::Rectangle).height,
        z: 0.0
      )
      trans = self.transform

      # FIXME: May want to support other shapes than rect
      Oid::BoundingBox.new(
        min: Oid::Vector3.new(
          x: trans.x,
          y: trans.y,
          z: trans.z,
        ),
        max: Oid::Vector3.new(
          x: trans.x + size.x,
          y: trans.y + size.y,
          z: trans.z + size.z
        )
      )
    end

    def bounds_cube : Oid::BoundingBox
      cubes = get_child(Oid::Cube)
      size = cubes.empty? ? Oid::Vector3.zero : cubes.first.as(Oid::Cube).size
      trans = self.transform

      # FIXME: May want to support other shapes than cube
      Oid::BoundingBox.new(
        min: Oid::Vector3.new(
          x: trans.x - (size.x/2),
          y: trans.y - (size.y/2),
          z: trans.z - (size.z/2),
        ),
        max: Oid::Vector3.new(
          x: trans.x + (size.x/2),
          y: trans.y + (size.y/2),
          z: trans.z + (size.z/2)
        )
      )
    end
  end
end
