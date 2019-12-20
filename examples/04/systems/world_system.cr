class Example::WorldSystem
  include Oid::Services::Helper
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem
  include Example::Helper

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
    contexts.stage
      .create_entity
      .add_state(
        pause: false,
        collision: false
      )
    # context.camera_entity.replace_position(
    #   Oid::Vector3.new(
    #     x: config_service.screen_w/2,
    #     y: config_service.screen_h/2,
    #     z: 0.0
    #   )
    # )
    # context.camera.offset = Oid::Vector3.new(
    #   x: config_service.screen_w/2,
    #   y: config_service.screen_h/2,
    #   z: 0.0
    # )

    generate_origin_grid
    generate_2d_grid 1000, 20.0
  end

  def execute
    actors.each do |entity|
      entity = entity.as(StageEntity)

      # ////////////////////////////////////////////////////
      # TODO: Add game logic!
      # ////////////////////////////////////////////////////
    end
  end
end
