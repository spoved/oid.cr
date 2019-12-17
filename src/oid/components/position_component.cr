@[Context(Stage, Input)]
@[Entitas::Event(EventTarget::Self)]
class Oid::Position < Entitas::Component
  prop :value, Oid::Vector3, default: Oid::Vector3.zero
end

@[Context(Stage)]
class Oid::PositionType < Entitas::Component
  prop :value, Oid::Enum::Position, default: Oid::Enum::Position::Relative
end
