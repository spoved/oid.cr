require "./game_object"

module Oid
  module Actor
    include Oid::GameObject

    abstract def name : String

    def bounds : Oid::BoundingBox
      cubes = get_child(Oid::Cube)
      size = cubes.empty? ? Oid::Vector3.zero : cubes.first.as(Oid::Cube).size
      # FIXME: May want to support other shapes than cube
      Oid::BoundingBox.new(
        min: Oid::Vector3.new(
          x: self.position.x - (size.x/2),
          y: self.position.y - (size.y/2),
          z: self.position.z - (size.z/2),
        ),
        max: Oid::Vector3.new(
          x: self.position.x + (size.x/2),
          y: self.position.y + (size.x/2),
          z: self.position.z + (size.x/2)
        )
      )
    end
  end
end
