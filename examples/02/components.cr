require "uuid"
require "uuid/json"

@[Context(Stage)]
class Player < Entitas::Component
  prop :id, UUID, default: UUID.random
end

@[Context(Stage)]
class Movable < Entitas::Component
end

#####################
# Input components

@[Context(Input)]
class Input < Entitas::Component
  prop :position, Oid::Vector2
end
