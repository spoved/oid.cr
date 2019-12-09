require "../../helpers/relationships"

module Oid
  module GameObject
    include JSON::Serializable

    include Oid::Helpers::Relationships(Oid::GameObject)

    property positioning : Oid::Enum::Position = Oid::Enum::Position::Relative
    property position : Oid::Vector3 = Oid::Vector3.zero

    def add_object(child : Oid::GameObject,
                   positioning : Oid::Enum::Position = Oid::Enum::Position::Relative,
                   position : Oid::Vector3 = Oid::Vector3.zero)
      child.positioning = positioning
      child.position = position
      self.add_child(child)
    end

    def transform
      case positioning
      when Oid::Enum::Position::Static
        self.position
      when Oid::Enum::Position::Relative
        (Oid::Matrix::Mat4.unit.translate(self.parent.as(GameObject).position) * @position.to_v4).to_v3
      when Oid::Enum::Position::Absolute
        (Oid::Matrix::Mat4.unit.translate(self.root.as(GameObject).position) * @position.to_v4).to_v3
      when Oid::Enum::Position::Fixed
        # TODO: position related to the camera
        raise "Unsuported positioning Oid::Enum::Position::Fixed"
      else
        raise "Unsuported positioning #{positioning}"
      end
    end
  end
end
