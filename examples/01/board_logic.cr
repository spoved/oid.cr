module BoardLogic
  extend self

  def get_board_pos(x, y, config_service)
    # (Oid::Vector2.new(x, y) / Oid::Vector2.new(800, 600))*10
    board_size = config_service.board_size
    res = config_service.resolution

    Oid::Vector2.new(x * res[0]/board_size.x, y * res[1]/board_size.y)
  end

  def get_next_empty_row(contexts, position)
    position.y = position.y - 1
    while position.y >= 0 && contexts.get_piece_with_position(contexts.stage, position).nil?
      position.y = position.y - 1
    end
    position.y + 1
  end
end
