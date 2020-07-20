# ////////////////////////////////////////////////////
# TODO: Define your components here
# ////////////////////////////////////////////////////

# Some example components:

@[Context(Ui)]
class Oid::Components::Interactive < Entitas::Component
end

@[Context(Stage, Ui)]
class Collision
  prop :ray, Oid::Ray
  prop :source, Entitas::Entity
  prop :target, Entitas::Entity
end
