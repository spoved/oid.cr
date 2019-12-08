require "../modules"

#####################
# Game components

@[Context(Game)]
class Asset < Entitas::Component
  prop :name, String
  prop :type, Oid::Enum::AssetType
end

@[Context(Game)]
@[Entitas::Event(EventTarget::Self)]
class Position < Entitas::Component
  prop :value, Oid::Vector3
end

@[Context(Game)]
class Direction < Entitas::Component
  prop :value, Float64
end

@[Context(Game)]
class Mover < Entitas::Component
end

@[Context(Game)]
class Move < Entitas::Component
  prop :target, Oid::Vector3
  prop :speed, Float64, default: 1.0
end

@[Context(Game)]
class MoveComplete < Entitas::Component
end

@[Context(Game)]
class View < Entitas::Component
  prop :scale, Float64, default: 1.0
  prop :rotation, Float64, default: 1.0
end

@[Context(Game)]
@[Entitas::Event(EventTarget::Self)]
class Destroyed < Entitas::Component
end

@[Context(Game)]
class Actor < Entitas::Component
  include Oid::Actor
end

@[Context(Game)]
class Camera < Entitas::Component
  include Oid::GameObject
  include Oid::Camera

  prop :mode, Oid::Camera::Mode, default: Oid::Camera::Mode::Mode2D
  prop :target, Oid::Vector3
  prop :offset, Oid::Vector3
  prop :rotation, Float64, default: 0.0
  prop :zoom, Float64, default: 1.0
end
