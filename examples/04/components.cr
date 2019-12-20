# ////////////////////////////////////////////////////
# TODO: Define your components here
# ////////////////////////////////////////////////////

# Some example components:
#
# @[Context(Game)]
# class Interactive < Entitas::Component
# end
#
# @[Context(Game)]
# class Movable < Entitas::Component
# end
#
# @[Context(Input)]
# class Input < Entitas::Component
#   prop :position, Oid::Vector2
# end

@[Context(Stage)]
@[Component::Unique]
class State < Entitas::Component
  prop :pause, Bool, default: false
  prop :collision, Bool, default: false
  prop :screen_upper_limit, Int32, default: 40
  prop :box_a_speed, Float64, default: 4.0
end

@[Context(Stage)]
class Oid::Collidable < Entitas::Component
end
