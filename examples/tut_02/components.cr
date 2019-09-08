require "../../src/oid"

@[Context(Game, Input, Ui)]
class Destroyed < Entitas::Component
end

@[Context(Game, Input, Ui)]
class AssignView < Entitas::Component
end

@[Context(Game, Input, Ui)]
class View < Entitas::Component
  prop :actor, Oid::IActor
end
