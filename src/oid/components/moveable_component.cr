@[Context(Stage)]
class Oid::Moveable < Entitas::Component; end

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
