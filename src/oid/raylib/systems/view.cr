class RayLib::ViewSystem
  include Oid::Service::View

  private property assets : Hash(String, RayLib::ViewController) = Hash(String, RayLib::ViewController).new
  private property textures : Hash(String, RayLib::Texture2D) = Hash(String, RayLib::Texture2D).new

  def load_asset(contexts : Contexts, entity : Entitas::IEntity, asset_type : Oid::Enum::AssetType, asset_name : String)
    unless assets[asset_name]?
      assets[asset_name] = RayLib::ViewController.new(contexts, entity)

      textures[asset_name] = RayLib.load_texture(
        File.join(contexts.meta.config_service.instance.asset_path, asset_name)
      )
    end

    entity.add_view(assets[asset_name])
    entity.add_rotation(Oid::Vector3.zero) unless entity.rotation?
    entity.add_scale unless entity.scale?
  end

  def draw(e : Oid::RenderableEntity)
    case e.asset.type
    when Oid::Enum::AssetType::Texture
      RayLib.draw_texture_ex(
        texture: textures[e.asset.name],
        position: RayLib::Vector2.new(
          e.position.value.x.to_f32,
          e.position.value.y.to_f32,
        ),
        rotation: e.rotation.value.magnitude.to_f32,
        scale: e.scale.value.to_f32,
        tint: Oid::Color::WHITE.to_unsafe
      )
    end
  end
end
