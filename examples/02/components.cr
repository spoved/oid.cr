require "uuid"
require "uuid/json"

@[Context(Game)]
class Player < Entitas::Component
  prop :id, UUID, default: UUID.random
end

@[Context(Game)]
class Actor < Entitas::Component
  include Oid::Actor
  prop :name, String
end

@[Context(Game)]
class Interactive < Entitas::Component
end

@[Context(Game)]
class Movable < Entitas::Component
end
