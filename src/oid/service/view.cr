module Oid
  module Service
    module View
      include Oid::Service

      # create a view from a premade asset (e.g. a prefab)
      abstract def load_asset(contexts : Contexts, entity : Entity::IEntity,
                              asset_type : Oid::Enum::AssetType, asset_name : String)

      abstract def renderable_entities(contexts)

      private setter render_group : Entitas::Group(StageEntity)? = nil

      def renderable_entities(contexts)
        @render_group ||= contexts.stage.get_group(
          StageMatcher.all_of(
            StageMatcher.view,
            StageMatcher.position,
          ).none_of(
            StageMatcher.destroyed
          )
        )
      end

      abstract def draw(entity : Oid::RenderableEntity)
    end
  end
end
