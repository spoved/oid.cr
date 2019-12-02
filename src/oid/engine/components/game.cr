@[Context(Game)]
class Asset < Entitas::Component
  prop :name, String
  prop :type, Oid::Enum::AssetType
end
