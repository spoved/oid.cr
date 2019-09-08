require "../../components/scene"
require "../../../utils/time"
require "../../../utils/math"

module Oid
  module Systems
    class MoveSystem
      include Entitas::Systems::CleanupSystem
      include Entitas::Systems::ExecuteSystem

      getter scene_context : SceneContext
      getter moves : Entitas::Group(SceneEntity)
      getter move_completes : Entitas::Group(SceneEntity)

      def initialize(contexts)
        @scene_context = contexts.scene
        @moves = scene_context.get_group(SceneMatcher.move)
        @move_completes = scene_context.get_group(SceneMatcher.move_complete)
      end

      def execute
        self.moves.each do |e|
          dir = e.move.target - e.position.value
          pos = e.position.value

          target_pos = e.move.target
          cur_pos = e.position.value

          dir = target_pos - cur_pos
          dist = dir.magnitude

          rel_speed = (e.move.speed * Oid::Time.delta_time.to_f32)

          if dist <= rel_speed
            e.replace_position(value: target_pos)
            e.remove_move
            e.is_move_complete = true
          else
            new_pos = cur_pos + dir.normalize * rel_speed
            e.replace_position(value: new_pos)

            angle = ::Math.atan2(dir.y, dir.x) * Oid::Math.rad2deg
            e.replace_direction(value: angle)
          end
        end
      end

      def cleanup
        self.move_completes.each do |e|
          e.is_move_complete = false
        end
      end
    end
  end
end
