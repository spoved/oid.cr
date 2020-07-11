module Oid
  module Systems
    class Board < Entitas::ReactiveSystem
      spoved_logger
      include Oid::Services::Helper
      include Entitas::Systems::InitializeSystem

      protected property contexts : Contexts
      protected property pieces : Entitas::Group(StageEntity)

      def initialize(@contexts)
        @pieces = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.piece, StageMatcher.position))
        @collector = get_trigger(@contexts.stage)
      end

      def filter(entity : StageEntity)
        entity.board?
      end

      def get_trigger(context : Entitas::Context) : Entitas::ICollector
        context.create_collector(StageMatcher.board)
      end

      def init
        entity = contexts.stage.create_entity
        config = contexts.meta.config_service.instance.as(ExampleConfigService)
        entity.add_board(config.board_size)
        scale = 0.5

        # res = Oid::Vector3.new(config.screen_w, config.screen_h, 0)
        config.board_size.y.to_i.times do |y|
          config.board_size.x.to_i.times do |x|
            pos = BoardLogic.get_board_pos(x, y, config).to_v3

            if rand(1.0) < config.blocker_probability
              # Create a blocker
              contexts.stage.create_entity
                .add_actor(name: "piece_#{x}_#{y}")
                .add_piece
                .add_position(pos)
                .add_scale(scale)
                .add_asset(name: "Blocker.png", type: Oid::Enum::AssetType::Texture)
            else
              # Create a random peice
              contexts.stage.create_entity
                .add_actor(name: "piece_#{x}_#{y}")
                .add_piece
                .add_movable
                .add_interactive
                .add_position(pos)
                .add_scale(scale)
                .add_asset(name: "Piece#{rand(6)}.png", type: Oid::Enum::AssetType::Texture)
            end

            logger.trace { "New piece created at #{x} => #{y}" }
          end
        end
      end

      def execute(entities : Array(Entitas::IEntity))
        board = entities.first.as(StageEntity).board.value
        config = contexts.meta.config_service.instance.as(ExampleConfigService)

        unless board.nil?
          self.pieces.each do |e|
            max_pos = BoardLogic.get_board_pos(board.x, board.y, config)
            if e.position.value.x >= max_pos.x || e.position.value.y >= max_pos.y
              puts "DESTROYYYYING"
              e.destroyed = true
            end
          end
        end
      end
    end
  end
end
