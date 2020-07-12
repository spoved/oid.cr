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
    # generate_2d_grid(1000, 20.0)
    mark_real_origin

    blocker_prob = config_service.blocker_probability
    square_size = (config_service.screen_h / (config_service.board_size.y + 2))
    board_width = config_service.board_size.x * square_size
    board_height = config_service.board_size.y * square_size

    board = create_outline(
      Oid::Vector3.new(config_service.screen_w/2, square_size, 0.0),
      width: board_width,
      height: board_height,
    )
    board.add_board

    config_service.board_size.x.to_i.times do |x|
      config_service.board_size.y.to_i.times do |y|
        piece = create_piece(x, y, square_size, board_width, board_height, blocker_prob)
        board.add_child(piece)
      end
    end

    score = create_label("score", "Score X",
      Oid::Vector3.new(0.0, 0.0, 600.0), Oid::Enum::OriginType::BottomCenter)
    board.add_child(score)
  end

  def create_piece(x, y, square_size, board_width, board_height, blocker_prob)
    context.create_entity
      .add_actor(name: "piece_#{x + y}")
      .add_position(
        (Oid::Vector3.new(x, y, 10.0) * square_size) - Oid::Vector3.new(board_width/2, 0.0, 0.0)
      )
      .add_position_type(Oid::Enum::Position::Relative)
      .add_scale(
        (square_size - 2)/128
      )
      .add_piece(
        Oid::Vector2.new(x, y)
      )
      .tap do |piece|
        if rand(1.0) < blocker_prob
          # Create a blocker
          piece.add_asset(
            name: "Blocker.png",
            type: Oid::Enum::AssetType::Texture
          )
            .add_blocker
        else
          piece.add_asset(
            name: "Piece#{rand(6)}.png",
            type: Oid::Enum::AssetType::Texture
          )
        end
      end
  end

  def execute
  end
end
