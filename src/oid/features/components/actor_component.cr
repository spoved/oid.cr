@[Context(Stage)]
@[Entitas::Event(EventTarget::Self)]
class Oid::Actor < Entitas::Component
  prop :name, String, not_nil: true, index: true
  prop :controllers, Set(Oid::Controller), default: Set(Oid::Controller).new
end
