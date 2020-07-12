module Oid
  module Transformable
    # property positioning : Oid::Enum::Position = Oid::Enum::Position::Relative
    # property position : Oid::Vector3 = Oid::Vector3.zero
    # property rotation : Oid::Vector3 = Oid::Vector3.zero

    abstract def position_type : Oid::Components::PositionType
    abstract def position : Oid::Components::Position
    abstract def rotation : Oid::Components::Rotation
    abstract def replace_rotation(value : Oid::Vector3)

    abstract def parent : Oid::Transformable
    abstract def root : Oid::Transformable

    def transform_origin : Oid::Vector3
      return Oid::Vector3.zero unless self.parent?
      case self.position_type.value
      when Oid::Enum::Position::Static
        Oid::Vector3.zero
      when Oid::Enum::Position::Relative
        if self.parent?
          self.parent.transform
        else
          Oid::Vector3.zero
        end
      when Oid::Enum::Position::Absolute
        if self.parent?
          self.root.position.value
        else
          Oid::Vector3.zero
        end
        # when Oid::Enum::Position::Fixed
        # FIXME: Finish
        # camera = Entitas::Contexts.shared_instance.game.camera.value
        # transform_position_rel_to(camera.position)
      else
        raise "Unsuported positioning #{self.position_type}"
      end
    end

    def transform_position_rel_to(origin, position) : Oid::Vector3
      (Oid::Matrix::Mat4.unit.translate(origin) * position.to_v4).to_v3
    end

    def transform : Oid::Vector3
      transform_position_rel_to(transform_origin, self.position.value)
    end

    def rotate(x_angle, y_angle, z_angle)
      self.replace_rotation(Oid::Vector3.new(
        (self.rotation.value.x >= 360 ? self.rotation.value.x - 360 : self.rotation.value.x) + x_angle,
        (self.rotation.value.y >= 360 ? self.rotation.value.y - 360 : self.rotation.value.y) + y_angle,
        (self.rotation.value.z >= 360 ? self.rotation.value.z - 360 : self.rotation.value.z) + z_angle,
      ))
      self
    end

    def rotate_x(angle)
      self.rotate(angle, 0, 0)
    end

    def rotate_y(angle)
      self.rotate(0, angle, 0)
    end

    def rotate_z(angle)
      self.rotate(0, 0, angle)
    end
  end
end
