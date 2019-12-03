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
@[Entitas::Event(EventTarget::Self)]
class Destroyed < Entitas::Component
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

@[Context(Game)]
class View < Entitas::Component
end

#####################
# Input components

@[Context(Input)]
class Input < Entitas::Component
  prop :position, Oid::Vector2
end

@[Component::Unique]
@[Context(Input)]
class LeftMouse < Entitas::Component
end

@[Component::Unique]
@[Context(Input)]
class RightMouse < Entitas::Component
end

@[Context(Input)]
class MouseUp < Entitas::Component
  prop :position, Oid::Vector2
end

@[Context(Input)]
class MouseDown < Entitas::Component
  prop :position, Oid::Vector2
end

@[Context(Input)]
class MouseReleased < Entitas::Component
  prop :position, Oid::Vector2
end

@[Context(Input)]
class MousePressed < Entitas::Component
  prop :position, Oid::Vector2
end

@[Component::Unique]
@[Context(Input)]
class Keyboard < Entitas::Component
end

@[Context(Input)]
class KeyUp < Entitas::Component
  prop :value, Oid::Enum::Key
  prop :position, Oid::Vector2
end

@[Context(Input)]
class KeyDown < Entitas::Component
  prop :value, Oid::Enum::Key
  prop :position, Oid::Vector2
end

@[Context(Input)]
class KeyReleased < Entitas::Component
  prop :value, Oid::Enum::Key
  prop :position, Oid::Vector2
end

@[Context(Input)]
class KeyPressed < Entitas::Component
  prop :value, Oid::Enum::Key
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
