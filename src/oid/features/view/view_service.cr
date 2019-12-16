module Oid
  module Service
    module ViewService
      include Oid::Service

      # create a view from a premade asset (e.g. a prefab)
      abstract def load_asset(
        contexts : Contexts,
        entity : Entity::IEntity,
        asset_type : Oid::Enum::AssetType,
        asset_name : String
      )
    end
  end
end
