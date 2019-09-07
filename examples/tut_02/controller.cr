require "./controller"
require "./systems/*"

class GameController < Entitas::Controller
  def create_systems(contexts : Contexts)
    Entitas::Feature.new("Systems")
      .add(MultiDestroySystem.new(contexts))
  end
end
