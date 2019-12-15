class Example::GameStateSystem
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem

  protected property contexts : Contexts
  protected property actors : Entitas::Group(GameEntity)
  protected property scenes : Entitas::Group(GameEntity)

  include_services Config

  def initialize(@contexts)
    @actors = @contexts.game.get_group(GameMatcher.all_of(GameMatcher.actor))
    @scenes = @contexts.game.get_group(GameMatcher.all_of(GameMatcher.scene))
  end

  def game_state
    contexts.game.state
  end

  def init
    _init_services

    contexts.game
      .create_entity
      .add_state(
        scene: "main_menu"
      )

    contexts.game
      .create_entity
      .add_scene(
        name: "main_menu",
      )
  end

  def execute
    scenes.each do |e|
      if e.scene.name == game_state.scene
        e.add_active_scene unless e.active_scene?
      else
        e.del_active_scene if e.active_scene?
      end
    end
  end
end
