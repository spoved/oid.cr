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

    contexts.game.create_entity.add_actor.add_position(Oid::Vector3.new(1.0, 1.0, 0.0))
  end
end
