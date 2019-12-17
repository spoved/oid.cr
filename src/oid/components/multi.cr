module Oid
  @[Context(Stage, Input)]
  @[Entitas::Event(EventTarget::Self)]
  class Destroyed < Entitas::Component; end

  @[Context(Stage, Input)]
  @[Entitas::Event(EventTarget::Self)]
  class Position < Entitas::Component
    prop :value, Oid::Vector3, default: Oid::Vector3.zero
  end
end
