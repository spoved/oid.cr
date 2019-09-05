require "./controller"
require "./systems/*"

class GameController < Entitas::Controller
  def create_systems(contexts : Contexts)
    Entitas::Feature.new("Systems")
      .add(InputSystems.new(contexts))
      .add(MovementSystems.new(contexts))
      .add(ViewSystems.new(contexts))
  end
end
