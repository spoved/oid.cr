require "../../src/oid"

@[Context(Game)]
class Position < Entitas::Component
  prop :value, RayLib::Vector2
end

@[Context(Game)]
class Direction < Entitas::Component
  prop :value, Float32
end

@[Context(Game)]
class View < Entitas::Component
  prop :actor, Oid::Actor
end

@[Context(Game)]
class Sprite < Entitas::Component
  prop :name, String
end

@[Context(Game)]
class Mover < Entitas::Component
end

@[Context(Game)]
class Move < Entitas::Component
  prop :target, RayLib::Vector2
end

@[Context(Game)]
class MoveComplete < Entitas::Component
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
  prop :position, RayLib::Vector2
end

@[Context(Input)]
class MouseDown < Entitas::Component
  prop :position, RayLib::Vector2
end

@[Context(Input)]
class MouseReleased < Entitas::Component
  prop :position, RayLib::Vector2
end

@[Context(Input)]
class MousePressed < Entitas::Component
  prop :position, RayLib::Vector2
end
