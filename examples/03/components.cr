# ////////////////////////////////////////////////////
# TODO: Define your components here
# ////////////////////////////////////////////////////

# Some example components:

@[Context(Game, Ui)]
class Interactive < Entitas::Component
end

@[Context(Input)]
class Input < Entitas::Component
  prop :position, Oid::Vector2
end

@[Context(Game, Ui)]
class Collision
  prop :ray, Oid::Ray
  prop :source, Entitas::Entity
  prop :target, Entitas::Entity
end
