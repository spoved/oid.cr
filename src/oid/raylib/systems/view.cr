class RayLib::ViewSystem
  include Oid::Service::View

  private property textures : Hash(String, RayLib::Texture2D) = Hash(String, RayLib::Texture2D).new

  def load_asset(
    contexts : Contexts,
    entity : Entitas::IEntity,
    asset_type : Oid::Enum::AssetType,
    asset_name : String
  )
    # TODO FINISH
    case asset_type
    when Oid::Enum::AssetType::Texture
      unless textures[asset_name]?
        textures[asset_name] = RayLib.load_texture(
          File.join(contexts.meta.config_service.instance.asset_path, asset_name)
        )
      end
    end
    entity.add_component_view(scale: 0.4)
    # contexts.game.create_entity.add_actor.add_position(Oid::Vector3.new(1.0, 1.0, 0.0))
  end

  def render(contexts : Contexts, entity : Entitas::IEntity)
    e = entity.as(GameEntity)
    case e.asset.type
    when Oid::Enum::AssetType::Texture
      RayLib.draw_texture_ex(
        texture: textures[e.asset.name],
        position: RayLib::Vector2.new(
          e.position.value.x.to_f32 * (800/10),
          e.position.value.y.to_f32 * (600/10),
        ),
        rotation: e.view.rotation.to_f32,
        scale: e.view.scale.to_f32,
        tint: Oid::Color::WHITE.to_unsafe
      )
    end
  end
end
