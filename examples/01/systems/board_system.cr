class Example::BoardSystem
  include Oid::Services::Helper
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem
  include Example::Helper

  include BoardLogic

  protected property contexts : Contexts
  protected property actors : Entitas::Group(StageEntity)
  protected property props : Entitas::Group(StageEntity)
  protected property pieces : Entitas::Group(StageEntity)

  def initialize(@contexts)
    @actors = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.actor))
    @props = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.prop))
    @pieces = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.piece).none_of(StageMatcher.destroyed))
  end

  def context
    contexts.stage
  end

  def config_service : ExampleConfigService
    super.as(ExampleConfigService)
  end

  def init
    mark_real_origin

    blocker_prob = config_service.blocker_probability
    square_size = (config_service.screen_h / (config_service.board_size.y + 2))
    board_width = config_service.board_size.x * square_size
    board_height = config_service.board_size.y * square_size

    board = create_rec(
      Oid::Vector3.new(config_service.screen_w/2, square_size, 0.0),
      width: board_width,
      height: board_height,
    )
    board.add_board(
      width: config_service.board_size.x.to_i,
      height: config_service.board_size.y.to_i,
      square_size: square_size,
    )

    board.board.each_pos do |x, y|
      piece = create_piece(context, x, y, square_size, board_width, board_height, blocker_prob)
      board.add_child(piece)
    end
  end

  def execute; end
end
