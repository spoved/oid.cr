require "../../src/oid"
require "../../src/oid/raylib/*"
require "./board_logic"
require "./components"
require "./systems/*"
require "./contexts_ext"

class RayLib::ConfigSystem
  add_settings(
    board_size : Oid::Vector2,
    blocker_probability : Float64,
    asset_path : String
  )
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
    config: RayLib::ConfigSystem.new,
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
      .add(Oid::Systems::Move.new(contexts))
  end
end

RayLib::ConfigSystem.configure do |settings|
  settings.screen_w = 800
  settings.screen_h = 600
  settings.target_fps = 120
  settings.show_fps = true
  settings.enable_mouse = true
  settings.enable_keyboard = true

  settings.asset_path = "examples/01/assets"
  settings.board_size = Oid::Vector2.new(10, 10)
  settings.blocker_probability = 0.1
end

controller = GameController.new
controller.start_server
app = RayLib::Application.new("Example 01")

app.start(
  controller: controller,
  init_hook: ->(cont : GameController) {},
  draw_hook: ->(cont : GameController) {
    Fiber.yield
    RayLib.draw_fps(10, 10)
  },
)
