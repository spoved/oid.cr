# class Entitas::Contexts
#   PIECE_POSITION_INDEX = "PiecePositionIndex"

#   @[Entitas::PostConstructor]
#   def init_piece_entity_indicies
#     stage.add_entity_index(
#       Entitas::PrimaryEntityIndex(StageEntity, Oid::Vector2).new(
#         PIECE_POSITION_INDEX,
#         stage.get_group(
#           StageMatcher
#             .all_of(StageMatcher.piece, StageMatcher.position)
#             .none_of(StageMatcher.destroyed)
#         ),
#         ->(entity : StageEntity, component : Entitas::IComponent?) {
#           return entity.piece.grid_pos unless component.is_a?(Piece)
#           component.nil? ? entity.piece.grid_pos : component.as(Piece).grid_pos
#         }
#       )
#     )
#   end

#   def get_piece_with_position(context : StageContext, position : Oid::Vector2) : StageEntity?
#     context.get_entity_index(PIECE_POSITION_INDEX)
#       .as(Entitas::PrimaryEntityIndex(StageEntity, Oid::Vector2))
#       .get_entity(position)
#   end
# end
