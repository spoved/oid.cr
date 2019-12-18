class Example::WorldSystem
  include Oid::Services::Helper
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem

  protected property contexts : Contexts
  protected property actors : Entitas::Group(StageEntity)

  def initialize(@contexts)
    @actors = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.actor))
  end

  def context
    contexts.stage
  end

  def init
    # ////////////////////////////////////////////////////
    # TODO: Initialize your world here!
    # ////////////////////////////////////////////////////
    context.create_entity
      .add_camera
      .add_position(Oid::Vector3.zero)

    context.create_entity
      .add_actor(name: "player")
      .add_camera_target
      .add_position(Oid::Vector3.zero)
      .add_asset(
        type: Oid::Enum::AssetType::Texture,
        name: "Blocker.png"
      )
  end

  def execute
    actors.each do |entity|
      entity = entity.as(StageEntity)

      if entity.actor? && entity.actor.name == "player"
        entity.replace_position(
          Oid::Vector3.new(
            x: 400.0,
            y: 300.0,
            z: 0.0,
          )
        )
      end
    end
  end
end
