class RayLib::ViewSystem
  include Oid::Service::View

  property assets : Hash(String, RayLib::ViewController) = Hash(String, RayLib::ViewController).new

  def load_asset(contexts : Contexts, entity : Entitas::IEntity, asset_type : Oid::Enum::AssetType, asset_name : String)
    unless assets[asset_name]?
      assets[asset_name] = RayLib::ViewController.new(contexts, entity)
    end

    entity.add_view(assets[asset_name])
  end
end
