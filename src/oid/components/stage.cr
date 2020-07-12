require "../resources/enum/*"

module Oid::Components
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

    def is_2d?
      !self.is_3d
    end

    def is_3d?
      self.is_3d
    end

    # target
    prop :target, Oid::Vector3, not_nil: true, default: Oid::Vector3.zero
    # Camera type: Perspective or Orthographic
    prop :type, Oid::Components::Camera::Type, default: Oid::Components::Camera::Type::Perspective
    # Camera mode
    prop :mode, Oid::Components::Camera::Mode, default: Oid::Components::Camera::Mode::Free
    # fov_y
    prop :fov, Float64, default: 50.0
    # zoom
    prop :zoom, Float64, default: 1.0
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
  @[Component::Unique]
  class RootView < Entitas::Component; end

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
    prop :origin, Oid::Enum::OriginType, default: Oid::Enum::OriginType::UpperLeft
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
  class ViewElement < Entitas::Component
    prop :value, Oid::Element
    prop :origin, Oid::Enum::OriginType, default: Oid::Enum::OriginType::UpperLeft
  end

  @[Context(Stage)]
  @[Entitas::Event(EventTarget::Self, EventType::Added)]
  @[Entitas::Event(EventTarget::Self, EventType::Removed)]
  class Hidden < Entitas::Component; end

  ##############################
  # Collidable Components
  ##############################

  @[Context(Stage)]
  class Collidable < Entitas::Component
  end

  @[Context(Stage)]
  class BoundingBox < Entitas::Component
    prop :value, Oid::Element::BoundingBox
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

##############################
# Renderable
##############################

module Oid
  module DestroyableEntity
    include Components::Destroyed::Helper
  end

  module ViewableEntity
    include DestroyableEntity

    include Components::Position::Helper
    include Components::PositionType::Helper
    include Components::Rotation::Helper
    include Components::Scale::Helper
    include Components::Asset::Helper
    include Components::AssetLoaded::Helper
    include Components::View::Helper
    include Components::ViewElement::Helper
  end

  module MovableEntity
    include Components::Moveable::Helper
    include Components::Direction::Helper
    include Components::Mover::Helper
    include Components::Move::Helper
    include Components::MoveComplete::Helper
  end

  module InteractableEntity
    include Components::Interactive::Helper
  end

  module CollidableEntity
    include Oid::ViewableEntity
    include Oid::Components::Collidable::Helper
  end

  module RenderableEntity
    include Oid::Relationships(RenderableEntity)
    include Oid::Transformable
    include DestroyableEntity
    include ViewableEntity
  end
end

class StageEntity < Entitas::Entity
  include Oid::RenderableEntity
  include Oid::CollidableEntity
end
