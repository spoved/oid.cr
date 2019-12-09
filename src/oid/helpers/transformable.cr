module Oid
  module Transformable
    property positioning : Oid::Enum::Position = Oid::Enum::Position::Relative
    property position : Oid::Vector3 = Oid::Vector3.zero
    property rotation : Oid::Vector3 = Oid::Vector3.zero

    abstract def parent : Oid::Transformable
    abstract def root : Oid::Transformable

    private def transform_position_rel_to(origin)
      (Oid::Matrix::Mat4.unit.translate(origin) * self.position.to_v4).to_v3
    end

    def transform
      case self.positioning
      when Oid::Enum::Position::Static
        self.position
      when Oid::Enum::Position::Relative
        transform_position_rel_to(self.parent.as(Oid::Transformable).position)
      when Oid::Enum::Position::Absolute
        transform_position_rel_to(self.root.as(Oid::Transformable).position)
      when Oid::Enum::Position::Fixed
        camera = Entitas::Contexts.shared_instance.game.camera.value
        transform_position_rel_to(camera.position)
      else
        raise "Unsuported positioning #{positioning}"
      end
    end

    def rotate(x_angle, y_angle, z_angle)
      self.rotation = Oid::Vector3.new(
        (self.rotation.x >= 360 ? self.rotation.x - 360 : self.rotation.x) + x_angle,
        (self.rotation.y >= 360 ? self.rotation.y - 360 : self.rotation.y) + y_angle,
        (self.rotation.z >= 360 ? self.rotation.z - 360 : self.rotation.z) + z_angle,
      )
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
