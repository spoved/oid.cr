#####################
# Config components

@[Context(Config)]
@[Component::Unique]
class ApplicationConfig < Entitas::Component
  prop :resolution, Oid::Vector2, default: Oid::Vector2.new(800, 600)
  prop :show_fps, Bool, default: false
  prop :target_fps, Int32, default: 120
end

@[Context(Config)]
@[Component::Unique]
class InputConfig < Entitas::Component
  prop :enable_mouse, Bool, default: false
  prop :enable_keyboard, Bool, default: false
end
