#####################
# Game components

@[Context(Game)]
class Actor < Entitas::Component
end

@[Component::Unique]
@[Context(Game)]
class Board < Entitas::Component
  prop :value, Oid::Vector2, default: Oid::Vector2.new(10, 10)
end

@[Context(Input)]
@[Component::Unique]
@[Entitas::Event(EventTarget::Any)]
@[Entitas::Event(EventTarget::Any, EventType::Removed)]
class BurstMode < Entitas::Component
end

@[Context(Game)]
class Interactive < Entitas::Component
end

@[Context(Game)]
class Movable < Entitas::Component
end

@[Context(Game)]
class Piece < Entitas::Component
end

#####################
# Input components

@[Context(Input)]
class Input < Entitas::Component
  prop :position, Oid::Vector2
end

#####################
# GameState components

@[Context(GameState)]
@[Component::Unique]
@[Entitas::Event(EventTarget::Any)]
class Score < Entitas::Component
  prop :value, Int32, default: 0
end

#####################
# Config components

@[Context(Config)]
@[Component::Unique]
class GameConfig < Entitas::Component
  prop :board_size, Oid::Vector2, default: Oid::Vector2.new(10, 10)
  prop :blocker_probability, Float64, default: 0.1
end
