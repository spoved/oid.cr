class Example::BoardSystem
  include Oid::Services::Helper
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem
  include Example::Helper

  protected property contexts : Contexts
  protected property actors : Entitas::Group(StageEntity)
  protected property props : Entitas::Group(StageEntity)

  def initialize(@contexts)
    @actors = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.actor))
    @props = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.prop))
  end

  def context
    contexts.stage
  end

  def config_service : ExampleConfigService
    super.as(ExampleConfigService)
  end

  def init
    # ////////////////////////////////////////////////////
    # TODO: Initialize your world here!
    # ////////////////////////////////////////////////////
    generate_2d_grid(1000, 20.0)
    mark_real_origin

    square_size = config_service.screen_h / (config_service.board_size.y + 2)

    board = create_outline(
      Oid::Vector3.new(config_service.screen_w/2, square_size, 0.0),
      width: config_service.board_size.x * square_size,
      height: config_service.board_size.y * square_size,
    )

    config_service.board_size.x.to_i.times do |x|
      config_service.board_size.y.to_i.times do |y|
        context.create_entity
          .add_actor(name: "piece_#{x}_#{y}")
          .add_position(Oid::Vector3.new(0.0, 0.0, 0.0))
          .add_position_type(Oid::Enum::Position::Relative)
      end
    end
  end

  def execute
  end
end
