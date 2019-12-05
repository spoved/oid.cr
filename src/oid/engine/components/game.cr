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
