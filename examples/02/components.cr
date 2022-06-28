require "uuid"
require "uuid/json"

@[Context(Stage)]
class Player < Entitas::Component
  prop :id, UUID, default: UUID.random
end

@[Context(Stage)]
class Movable < Entitas::Component
end
