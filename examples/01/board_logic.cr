module BoardLogic
  def create_piece(context, x, y, square_size, board_width, board_height, blocker_prob)
    context.create_entity
      .add_actor(name: "piece_#{x + y}")
      .add_position(
        piece_position(x, y, square_size, board_width)
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

  def piece_position(x, y, square_size, board_width)
    (Oid::Vector3.new(x, y, 10.0) * square_size) - Oid::Vector3.new(board_width/2, 0.0, 0.0)
  end
end
