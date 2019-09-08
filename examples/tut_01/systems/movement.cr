require "../components"
require "../../../src/oid/utils/time"
require "../../../src/oid/utils/math"

class MoveSystem
  spoved_logger

  include Entitas::Systems::CleanupSystem
  include Entitas::Systems::ExecuteSystem

  getter game_context : GameContext
  getter moves : Entitas::Group(GameEntity)
  getter move_completes : Entitas::Group(GameEntity)
  getter speed = 0.5f32

  def initialize(contexts)
    @game_context = contexts.game
    @moves = contexts.game.get_group(GameMatcher.move)
    @move_completes = contexts.game.get_group(GameMatcher.move_complete)
  end

  def execute
    self.moves.each do |e|
      dir = e.move.target.as(RayLib::Vector2) - e.position.value.as(RayLib::Vector2)
      pos = e.position.value.as(RayLib::Vector2)

      target_pos = e.move.target.as(RayLib::Vector2)
      cur_pos = e.position.value.as(RayLib::Vector2)

      dir = target_pos - cur_pos
      dist = dir.magnitude

      rel_speed = (self.speed * Oid::Time.delta_time.to_f32)

      if dist <= rel_speed
        e.replace_position(value: target_pos)
        e.remove_move
        e.is_move_complete = true
      else
        new_pos = cur_pos + dir.normalize * rel_speed
        e.replace_position(value: new_pos)

        angle = Math.atan2(dir.y, dir.x) * Oid::Math.rad2deg
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

class MovementSystems < Entitas::Feature
  def initialize(contexts)
    @name = "Movements Systems"
    add MoveSystem.new(contexts)
  end
end
