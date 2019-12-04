require "../../src/oid"
require "../../src/oid/raylib/*"
require "./board_logic"
require "./components"
require "./systems/*"
require "./services/*"
require "./contexts_ext"

class ConfigService
  include Oid::Service::Config

  def enable_mouse? : Bool
    true
  end

  def enable_keyboard? : Bool
    true
  end
end

class ApplicationService
  include Oid::Service::Application
  property frame_count = 0
end

class GameController < Entitas::Controller
  getter services = Services.new(
    application: ApplicationService.new,
    logger: RayLib::LoggerSystem.new,
    input: RayLib::InputSystem.new,
    config: ConfigService.new,
    time: RayLib::TimeSystem.new,
    view: RayLib::ViewSystem.new,
  )

  def create_systems(contexts : Contexts)
    Entitas::Feature.new("Systems")
      .add(ServiceRegistrationSystems.new(contexts, services))
      .add(Game::EventSystems.new(contexts))
      .add(Oid::Systems::LoadAsset.new(contexts))
      .add(Oid::Systems::EmitInput.new(contexts))
      .add(Oid::Systems::Input.new(contexts))
      .add(Oid::Systems::ProcessInput.new(contexts))
      .add(Oid::Systems::Board.new(contexts))
      .add(Oid::Systems::Fall.new(contexts))
  end
end

controller = GameController.new
controller.start_server

app = RayLib::Application.new("TEST")

app.start(
  controller: controller,
  init_hook: ->(cont : GameController) {
  },
  draw_hook: ->(cont : GameController) {
    group = cont.contexts.game.get_group(
      GameMatcher
        .all_of(
          GameMatcher.view,
          GameMatcher.position,
          GameMatcher.asset,
        )
        .none_of(
          GameMatcher.destroyed
        )
    )

    group.each do |e|
      if e.view?
        cont.contexts.meta.view_service.instance.render(cont.contexts, e)
      end
    end
    Fiber.yield

    RayLib.draw_fps(10, 10)
  },
)
