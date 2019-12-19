module Oid
  module Transformable
    # property positioning : Oid::Enum::Position = Oid::Enum::Position::Relative
    # property position : Oid::Vector3 = Oid::Vector3.zero
    # property rotation : Oid::Vector3 = Oid::Vector3.zero

    abstract def position_type : Oid::PositionType
    abstract def position : Oid::Position
    abstract def rotation : Oid::Rotation
    abstract def replace_rotation(value : Oid::Vector3)

    abstract def parent : Oid::Transformable
    abstract def root : Oid::Transformable

    private def transform_position_rel_to(origin) : Oid::Vector3
      (Oid::Matrix::Mat4.unit.translate(origin) * self.position.value.to_v4).to_v3
    end

    def transform : Oid::Vector3
      case self.position_type.value
      when Oid::Enum::Position::Static
        self.position.value
      when Oid::Enum::Position::Relative
        if self.parent?
          transform_position_rel_to(self.parent.transform)
        else
          transform_position_rel_to(Oid::Vector3.zero)
        end
      when Oid::Enum::Position::Absolute
        if self.parent?
          transform_position_rel_to(self.root.position.value)
        else
          transform_position_rel_to(Oid::Vector3.zero)
        end
        # when Oid::Enum::Position::Fixed
        # FIXME: Finish
        # camera = Entitas::Contexts.shared_instance.game.camera.value
        # transform_position_rel_to(camera.position)
      else
        raise "Unsuported positioning #{self.position_type}"
      end
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
