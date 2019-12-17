module Oid
  ##############################
  # Mouse Components
  ##############################

  @[Context(Input)]
  @[Component::Unique]
  class MouseWheel < Entitas::Component
    prop :move, Int32
  end

  @[Context(Input)]
  @[Component::Unique]
  class LeftMouse < Entitas::Component; end

  @[Context(Input)]
  @[Component::Unique]
  class RightMouse < Entitas::Component; end

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

  ##############################
  # Keyboard Components
  ##############################

  @[Context(Input)]
  class Keyboard < Entitas::Component
    prop :key, Oid::Enum::Key
  end

  @[Context(Input)]
  class KeyUp < Entitas::Component; end

  @[Context(Input)]
  class KeyDown < Entitas::Component; end

  @[Context(Input)]
  class KeyReleased < Entitas::Component; end

  @[Context(Input)]
  class KeyPressed < Entitas::Component; end
end
