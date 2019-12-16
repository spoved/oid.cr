@[Context(Stage)]
class Oid::Position < Entitas::Component
  prop :type, Oid::Enum::Position, default: Oid::Enum::Position::Relative
  prop :value, Oid::Vector3, default: Oid::Vector3.zero
end

@[Context(Stage)]
class Oid::Rotation < Entitas::Component
  prop :value, Oid::Vector3, default: Oid::Vector3.zero
end

@[Context(Stage)]
class Oid::Scale < Entitas::Component
  prop :value, Float64, default: 1.0
end

@[Context(Stage)]
class Oid::Camera < Entitas::Component
  enum Mode
    Custom
    Free
    Orbital
    FirstPerson
    ThirdPerson
  end

  enum Type
    Perspective
    Orthographic
  end

  # 3d
  prop :is_3d, Bool, default: false
  # Camera type: Perspective or Orthographic
  prop :type, Oid::Camera::Type, default: Oid::Camera::Type::Perspective
  # Camera mode
  prop :mode, Oid::Camera::Mode, default: Oid::Camera::Mode::Free
  # fov_y
  prop :fov, Float64, default: 50.0
  # zoom
  prop :zoom, Float64, default: 0.0
  # offset
  prop :offset, Oid::Vector3, default: Oid::Vector3.zero
end

@[Context(Stage)]
class Oid::CameraTarget < Entitas::Component
end
