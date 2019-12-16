class Entitas::Contexts
  PIECE_POSITION_INDEX = "PiecePositionIndex"

  @[Entitas::PostConstructor]
  def init_piece_entity_indicies
    game.add_entity_index(
      Entitas::PrimaryEntityIndex(GameEntity, Oid::Vector2).new(
        PIECE_POSITION_INDEX,
        game.get_group(
          GameMatcher
            .all_of(GameMatcher.piece, GameMatcher.position)
            .none_of(GameMatcher.destroyed)
        ),
        ->(entity : GameEntity, component : Entitas::IComponent?) {
          return entity.position.value.to_v2 unless component.is_a?(Position)
          component.nil? ? entity.position.value.to_v2 : component.as(Position).value.to_v2
        }
      )
    )
  end

  def get_piece_with_position(context : GameContext, position : Oid::Vector2) : GameEntity?
    context.get_entity_index(PIECE_POSITION_INDEX)
      .as(Entitas::PrimaryEntityIndex(GameEntity, Oid::Vector2))
      .get_entity(position)
  end

  # def get_next_empty_row(contexts : Contexts, position : Oid::Vector2)
  # end
end
