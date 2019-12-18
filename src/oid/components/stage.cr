module Oid
  @[Context(Stage)]
  @[Entitas::Event(EventTarget::Self)]
  class Actor < Entitas::Component
    prop :name, String, not_nil: true, index: true
    # prop :controllers, Set(Oid::Controller), default: Set(Oid::Controller).new
  end

  @[Context(Stage)]
  @[Entitas::Event(EventTarget::Self)]
  class Prop < Entitas::Component
    prop :name, String, not_nil: true, index: true
    # prop :controllers, Set(Oid::Controller), default: Set(Oid::Controller).new
  end

  ##############################
  # Camera Components
  ##############################

  @[Context(Stage)]
  @[Component::Unique]
  class Camera < Entitas::Component
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
    prop :is_3d, Bool, default: (false)
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
  @[Component::Unique]
  class CameraTarget < Entitas::Component; end

  ##############################
  # View Components
  ##############################

  @[Context(Stage)]
  class PositionType < Entitas::Component
    prop :value, Oid::Enum::Position, default: Oid::Enum::Position::Relative
  end

  @[Context(Stage)]
  class Rotation < Entitas::Component
    prop :value, Oid::Vector3, default: Oid::Vector3.zero
  end

  @[Context(Stage)]
  class Scale < Entitas::Component
    prop :value, Float64, default: 1.0
  end

  @[Context(Stage)]
  class Asset < Entitas::Component
    prop :type, Oid::Enum::AssetType, not_nil: true
    prop :name, String, not_nil: true
  end

  @[Context(Stage)]
  class AssetLoaded < Entitas::Component; end

  @[Context(Stage)]
  class View < Entitas::Component
    prop :value, Oid::Controller::View
  end

  @[Context(Stage)]
  class Renderable < Entitas::Component
    prop :value, Oid::Element
  end

  ##############################
  # Move Components
  ##############################

  @[Context(Stage)]
  class Moveable < Entitas::Component; end

  @[Context(Stage)]
  class Direction < Entitas::Component
    prop :value, Float64
  end

  @[Context(Stage)]
  class Mover < Entitas::Component
  end

  @[Context(Stage)]
  class Move < Entitas::Component
    prop :target, Oid::Vector3
    prop :speed, Float64, default: 1.0
  end

  @[Context(Stage)]
  class MoveComplete < Entitas::Component; end

  ##############################
  # Input Components
  ##############################

  @[Context(Stage)]
  class Interactive < Entitas::Component; end
end
