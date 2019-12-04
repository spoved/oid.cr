module BoardLogic
  extend self

  def get_next_empty_row(contexts, position)
    position.y = position.y - 1
    while position.y >= 0 && contexts.get_piece_with_position(contexts.game, position).nil?
      position.y = position.y - 1
    end
    position.y + 1
  end
end
