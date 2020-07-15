class Example::FallSystem < Entitas::ReactiveSystem
  spoved_logger
  include BoardLogic
  protected property contexts : Contexts
  protected property pieces : Entitas::Group(StageEntity)

  def initialize(@contexts)
    @collector = get_trigger(@contexts.stage)
    @pieces = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.piece).none_of(StageMatcher.blocker))
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(StageMatcher.all_of(StageMatcher.destroyed, StageMatcher.piece))
  end

  def filter(entity : StageEntity)
    entity.piece? && entity.destroyed?
  end

  def execute(entities : Array(Entitas::IEntity))
    board = contexts.stage.board
    board_width = board.width * board.square_size

    entities.each do |e|
      board_pos = e.as(StageEntity).piece.grid_pos
      board.each_pos do |x, y|
        if x == board_pos.x && y < board_pos.y
          e = pieces.find { |pi| pi.piece.grid_pos == Oid::Vector2.new(x, y) }
          next if e.nil? || e.move?

          new_grid_pos = Oid::Vector2.new(x, y + 1)
          puts "Need to move piece to pos: #{e.piece.grid_pos} to #{new_grid_pos}"

          # e.replace_piece(new_grid_pos)
          # pos = piece_position(x, y, board.square_size, board_width)
          # e.add_move(
          #   target: pos,
          #   speed: 1.0,
          # )
        end
      end
    end

    # board.x.to_i.times do |x|
    #   board.y.to_i.times do |y|
    #     position = SF::Vector2(Int32).new(x, y)
    #     e = contexts.get_piece_with_position(contexts.game, position)
    #     if !e.nil? && e.movable?
    #       move_down(e, position)
    #     end
    #   end
    # end
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
