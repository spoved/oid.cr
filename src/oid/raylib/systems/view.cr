class RayLib::ViewSystem
  include Oid::Service::View

  def load_asset(
    contexts : Contexts,
    entity : Entitas::IEntity,
    asset_type : Oid::Enum::AssetType,
    asset_name : String
  )
    # TODO FINISH
    puts "#{asset_type} - #{asset_name}"
  end
end
