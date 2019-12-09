require "../../src/oid"
require "../../src/oid/raylib/*"
require "./components"
require "./config"
require "./systems/*"

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
      .add(OidSystems.new(contexts))
      .add(WorldSystem.new(contexts))
  end
end

controller = GameController.new
controller.start_server
app = RayLib::Application.new("Example 02")

app.start(
  controller: controller,
  init_hook: ->(cont : GameController) {},
  draw_hook: ->(cont : GameController) {
    # RayLib.draw_rectangle(-6000, 320, 13000, 8000, Oid::Color::GRAY.to_unsafe)
    camera = cont.contexts.game.camera.value.as(Oid::Camera2D)
  # Rotate by 1
  # camera.rotation += 1.0
  },
)
