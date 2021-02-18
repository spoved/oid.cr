module Oid
  module Transformable
    # property positioning : Oid::Enum::Position = Oid::Enum::Position::Relative
    # property position : Oid::Vector3 = Oid::Vector3.zero
    # property rotation : Oid::Vector3 = Oid::Vector3.zero

    abstract def position_type : Oid::Components::PositionType
    abstract def position : Oid::Components::Position
    abstract def rotation : Oid::Components::Rotation
    abstract def scale : Oid::Components::Scale
    abstract def replace_rotation(value : Oid::Vector3)

    abstract def parent : Oid::Transformable
    abstract def root : Oid::Transformable

    private getter transform_cache : Oid::Vector3 = Oid::Vector3.zero

    def transform_origin : Oid::Vector3
      return Oid::Vector3.zero unless self.parent?

      case self.position_type.value
      when Oid::Enum::Position::Static
        Oid::Vector3.zero
      when Oid::Enum::Position::Relative
        if self.parent?
          self.parent.transform(false)
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

    # Calculate and update the cached transform
    def calculate_transform
      @transform_cache = transform_position_rel_to(transform_origin, self.position.value)
    end

    # Return the position in relation to defined parent. Pass `use_cache` as `true` to use
    # last caclulated value (useful for sort commands)
    def transform(use_cache = false) : Oid::Vector3
      calculate_transform unless use_cache
      @transform_cache
    end

    # Relative scale compared to its parent
    def rel_scale : Float64
      (self.parent? ? self.parent.rel_scale : 1.0) * self.scale.value
    end

    # Normalize the rotation value between -180 and 180 degrees
    def rotation_norm : Oid::Vector3
      rot = self.rotation.value

      while rot.x < -180.0
        rot.x += 360
      end

      while rot.y < -180.0
        rot.y += 360
      end

      while rot.z < -180.0
        rot.z += 360
      end

      while rot.x > 180.0
        rot.x -= 360
      end

      while rot.y > 180.0
        rot.y -= 360
      end

      while rot.z > 180.0
        rot.z -= 360
      end

      rot
    end

    def rotate(vector : Oid::Vector3)
      rotate(vector.x, vector.y, vector.z)
    end

    def rotate(x_angle, y_angle, z_angle)
      x_angle += 360 if x_angle < -180.0
      y_angle += 360 if y_angle < -180.0
      z_angle += 360 if z_angle < -180.0

      rot = Oid::Vector3.new(x_angle, y_angle, z_angle)
      self.replace_rotation(rotation_norm + rot)
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
