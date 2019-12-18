require "../../src/oid"
require "../../src/oid/raylib/*"
require "./components"
require "./config"
require "./systems/*"

create_feature Example, [
  Example::InputSystem,
  Example::WorldSystem,
  Example::UiSystem,
  BoxSystem,
  CollisionSystem,

  # ////////////////////////////////////////////////////
  # TODO: Place any services created here
  # ////////////////////////////////////////////////////
]

class Example::ApplicationService
  include Oid::Service::Application
end

class GameController < Entitas::Controller
  getter services = Services.new(
    application: Example::ApplicationService.new,
    logger: RayLib::LoggerService.new,
    input: RayLib::InputService.new,
    config: RayLib::ConfigService.new,
    time: RayLib::TimeService.new,
    view: RayLib::ViewService.new,
  )

  def create_systems(contexts : Contexts)
    Entitas::Feature.new("Systems")
      .add(ServiceRegistrationSystems.new(contexts, services))
      .add(Game::EventSystems.new(contexts))
      .add(OidSystems.new(contexts))
      .add(ExampleSystems.new(contexts))
  end
end

controller = GameController.new
controller.start_server
app = RayLib::Application.new("example")

app.start(
  controller: controller,
  init_hook: ->(cont : GameController) {},
  draw_hook: ->(cont : GameController) {},
)
