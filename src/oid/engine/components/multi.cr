@[Context(Game, Input)]
@[Entitas::Event(EventTarget::Self)]
class Destroyed < Entitas::Component
end

@[Context(Game, Input)]
@[Entitas::Event(EventTarget::Self)]
class Position < Entitas::Component
  prop :value, Oid::Vector3
end
