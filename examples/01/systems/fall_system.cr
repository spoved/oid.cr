class Example::FallSystem < Entitas::ReactiveSystem
  spoved_logger
  include BoardLogic
  protected property contexts : Contexts
  protected property pieces : Entitas::Group(StageEntity)

  def initialize(@contexts)
    @collector = get_trigger(@contexts.stage)
    @pieces = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.piece))
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(StageMatcher.all_of(StageMatcher.destroyed, StageMatcher.piece))
  end

  def filter(entity : StageEntity)
    entity.piece? && entity.destroyed?
  end

  def execute(entities : Array(Entitas::IEntity))
    board = contexts.stage.board
    entities.each do |destroyed_e|
      destroyed_pos = destroyed_e.as(StageEntity).piece.grid_pos

      # Gather pieces above
      ps = pieces.select { |piece| piece.piece.grid_pos.x == destroyed_pos.x && piece.piece.grid_pos.y < destroyed_pos.y }
      # logger.warn { ps.map &.to_s }
      ps.sort { |a, b| b.piece.grid_pos.y <=> a.piece.grid_pos.y }.each do |piece|
        # Break loop if there is a blocker
        break if piece.blocker?
        move_down(piece, board)
      end
    end
  end

  def move_down(e, board)
    board_width = board.width * board.square_size
    new_grid_pos = Oid::Vector2.new(e.piece.grid_pos.x, e.piece.grid_pos.y + 1)
    logger.info { "Need to move #{e.to_s} at pos: #{e.piece.grid_pos} to #{new_grid_pos}" }

    # Replace the position with its new one
    e.replace_piece(new_grid_pos)

    # Move piece to its new target pos
    pos = piece_position(new_grid_pos.x, new_grid_pos.y, board.square_size, board_width)
    logger.debug { "#{e.position.value} => #{pos}" }
    e.replace_move(
      target: pos,
      speed: 1.0,
    )
  end

  # def move_down(entity : GameEntity, position : SF::Vector2(Int32))
  #   empty_row = BoardLogic.get_next_empty_row(contexts, position)

  #   if empty_row != position.y
  #     entity.add_move(
  #       target: SF::Vector3(Int32).new(
  #         x: position.x.to_i,
  #         y: empty_row,
  #         z: 0
  #       ),
  #       speed: 0.01
  #     )
  #   end
  # end
end
