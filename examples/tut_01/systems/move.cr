module Oid
  module Systems
    class Move
      include Entitas::Systems::CleanupSystem
      include Entitas::Systems::InitializeSystem
      include Entitas::Systems::ExecuteSystem

      getter contexts : Contexts
      getter game_context : GameContext
      getter moves : Entitas::Group(GameEntity)
      getter move_completes : Entitas::Group(GameEntity)
      protected setter time_service : Oid::Service::Time? = nil

      def initialize(@contexts)
        @game_context = @contexts.game
        @moves = @game_context.get_group(GameMatcher.move)
        @move_completes = @game_context.get_group(GameMatcher.move_complete)
      end

      def init
        @time_service = contexts.meta.time_service.instance
      end

      def time_service : Oid::Service::Time
        @time_service ||= contexts.meta.time_service.instance
      end

      def execute
        self.moves.each do |e|
          dir = e.move.target - e.position.value
          pos = e.position.value

          target_pos = e.move.target
          cur_pos = e.position.value

          dir = target_pos - cur_pos
          dist = dir.magnitude

          rel_speed = (e.move.speed * time_service.delta_time)

          if dist <= rel_speed
            e.replace_position(value: target_pos)
            e.remove_move
            e.move_complete = true
          else
            new_pos = cur_pos + dir.normalize * rel_speed
            e.replace_position(value: new_pos)

            angle = ::Math.atan2(dir.y, dir.x) * ::Math.rad2deg
            e.replace_direction(value: angle)
          end
        end
      end

      def cleanup
        self.move_completes.each do |e|
          e.move_complete = false
        end
      end
    end
  end
end
