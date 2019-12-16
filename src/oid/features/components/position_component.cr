@[Context(Stage)]
@[Entitas::Event(EventTarget::Self)]
class Oid::Position < Entitas::Component
  prop :type, Oid::Enum::Position, default: Oid::Enum::Position::Relative
  prop :value, Oid::Vector3, default: Oid::Vector3.zero
end
