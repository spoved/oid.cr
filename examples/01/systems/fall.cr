module Oid
  module Systems
    class Fall < Entitas::ReactiveSystem
      spoved_logger

      protected property contexts : Contexts

      def initialize(@contexts)
        @collector = get_trigger(@contexts.stage)
      end

      def get_trigger(context : Entitas::Context) : Entitas::ICollector
        context.create_collector(StageMatcher.destroyed)
      end

      def filter(entity : StageEntity)
        entity.piece? && entity.destroyed?
      end

      def execute(entities : Array(Entitas::IEntity))
        board = contexts.stage.board.value
        board.x.to_i.times do |x|
          board.y.to_i.times do |y|
            position = Oid::Vector2.new(x, y)

            e = contexts.get_piece_with_position(contexts.stage, position)
            if !e.nil? && e.movable?
              move_down(e, position)
            end
          end
        end
      end

      def move_down(entity : StageEntity, position : Oid::Vector2)
        empty_row = BoardLogic.get_next_empty_row(contexts, position)

        if empty_row != position.y
          entity.add_move(
            target: Oid::Vector3.new(
              x: position.x.to_i,
              y: empty_row,
              z: 0
            ),
            speed: 0.01
          )
        end
      end
    end
  end
end
