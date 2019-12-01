@[Context(Game)]
class Asset < Entitas::Component
  prop :name, String
  prop :asset_type, Oid::Enum::AssetType
end
