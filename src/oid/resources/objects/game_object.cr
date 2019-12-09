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
  end
end
