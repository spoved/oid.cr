@[Context(Stage)]
class Oid::Rotation < Entitas::Component
  prop :value, Oid::Vector3, default: Oid::Vector3.zero
end

@[Context(Stage)]
class Oid::Scale < Entitas::Component
  prop :value, Float64, default: 1.0
end

@[Context(Stage)]
class Oid::Asset < Entitas::Component
  prop :name, String, not_nil: true
end
