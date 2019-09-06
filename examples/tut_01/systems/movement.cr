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
