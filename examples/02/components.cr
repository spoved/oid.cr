require "uuid"
require "uuid/json"

@[Context(Game)]
class Player < Entitas::Component
  prop :id, UUID, default: UUID.random
end

@[Context(Game)]
class Interactive < Entitas::Component
end

@[Context(Game)]
class Movable < Entitas::Component
end

#####################
# Input components

@[Context(Input)]
class Input < Entitas::Component
  prop :position, Oid::Vector2
end
