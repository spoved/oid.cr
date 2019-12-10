require "../../resources/objects"

#####################
# Game components

@[Context(Game)]
class Asset < Entitas::Component
  prop :name, String
  prop :type, Oid::Enum::AssetType
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
@[Component::Unique]
class Camera < Entitas::Component
  include Oid::GameObject
  prop :value, Oid::Camera
end

@[Context(Game)]
class Actor < Entitas::Component
  include Oid::Actor
  prop :name, String
end
