module Oid
  module Systems
    class Board < Entitas::ReactiveSystem
      spoved_logger

      include Entitas::Systems::InitializeSystem

      protected property contexts : Contexts
      protected property pieces : Entitas::Group(GameEntity)

      def initialize(@contexts)
        @pieces = @contexts.game.get_group(GameMatcher.all_of(GameMatcher.piece, GameMatcher.position))
        @collector = get_trigger(@contexts.game)
      end

      def filter(entity : GameEntity)
        entity.board?
      end

      def get_trigger(context : Entitas::Context) : Entitas::ICollector
        context.create_collector(GameMatcher.board)
      end

      def init
        entity = contexts.game.create_entity

        unless contexts.config.game_config?
          contexts.config
            .create_entity
            .add_game_config(
              board_size: Oid::Vector2.new(10, 10)
            )
        end

        config = contexts.config.game_config
        entity.add_board(config.board_size)

        config.board_size.y.to_i.times do |y|
          config.board_size.x.to_i.times do |x|
            logger.unknown "New piece created at #{x} => #{y}"
            if rand(1.0) < config.blocker_probability
              # Create a blocker
              contexts.game.create_entity
                .add_piece
                .add_position(Oid::Vector3.new(x, y, 0))
                .add_asset(name: "Blocker.png", type: Oid::Enum::AssetType::Texture)
            else
              # Create a random peice
              contexts.game.create_entity
                .add_piece
                .add_movable
                .add_interactive
                .add_position(Oid::Vector3.new(x, y, 0))
                .add_asset(name: "Piece#{rand(6)}.png", type: Oid::Enum::AssetType::Texture)
            end
          end
        end
      end

      def execute(entities : Array(Entitas::IEntity))
        board = entities.first.as(GameEntity).board.value
        unless board.nil?
          self.pieces.each do |e|
            if e.position.value.x >= board.x || e.position.value.y >= board.y
              e.destroyed = true
            end
          end
        end
      end
    end
  end
end
