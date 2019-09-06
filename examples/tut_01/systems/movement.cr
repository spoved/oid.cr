require "../components"

class MoveSystem
  include Entitas::Systems::CleanupSystem
  include Entitas::Systems::ExecuteSystem

  getter game_context : GameContext
  getter moves : Entitas::Group(GameEntity)
  getter move_completes : Entitas::Group(GameEntity)
  getter speed = 4f32

  def initialize(contexts)
    @game_context = contexts.game
    @moves = contexts.game.get_group(GameMatcher.move)
    @move_completes = contexts.game.get_group(GameMatcher.move_complete)
  end

  def execute
    self.moves.each do |e|
      dir = e.move.target.as(RayLib::Vector2) - e.position.value.as(RayLib::Vector2)
      pos = e.position.value.as(RayLib::Vector2)
      new_pos = pos + dir.normalize * self.speed
      e.replace_position(value: new_pos)

      # Rad2Deg = 360 / (PI * 2)
      angle = Math.atan2(dir.y, dir.x) * (360 / (Math::PI * 2))
      e.replace_direction(value: angle)

      dist = dir.magnitude

      if dist <= 0.5f32
        e.remove_move
        e.is_move_complete = true
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
