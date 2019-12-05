#####################
# Input components

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
