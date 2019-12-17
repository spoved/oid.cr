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
  prop :type, Oid::Enum::AssetType, not_nil: true
  prop :name, String, not_nil: true
end

@[Context(Stage)]
class Oid::Renderable < Entitas::Component
  prop :value, Oid::Element
end

@[Context(Stage)]
class Oid::AssetLoaded < Entitas::Component; end

@[Context(Stage)]
class Oid::View < Entitas::Component
  prop :value, Oid::Controller::View
end
