module Oid
  module Service
    module View
      include Oid::Service

      # create a view from a premade asset (e.g. a prefab)
      abstract def load_asset(
        contexts : Contexts,
        entity : Entity::IEntity,
        asset_type : Oid::Enum::AssetType,
        asset_name : String
      )

      abstract def render(contexts : Contexts, entity : Entitas::IEntity)
    end
  end
end
