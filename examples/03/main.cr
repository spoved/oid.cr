require "../../src/oid"
require "../../src/raylib"
require "../helpers/*"
require "./components"
require "./systems/**"

RAYLIB_CONFIG = {
  app_name:        "Example 03 - 3d collision",
  screen_w:        800,
  screen_h:        600,
  target_fps:      120,
  show_fps:        true,
  enable_mouse:    true,
  enable_keyboard: false,
  camera_mode:     "3d",
  asset_path:      "./examples/assets",
}

create_feature Example, [
  Example::WorldSystem,
  Example::UISystem,
  Example::CollisionEmitSystem,
  Example::CollisionProcessSystem,

  # ////////////////////////////////////////////////////
  # TODO: Place any services created here
  # ////////////////////////////////////////////////////
]

class AppController < Entitas::Controller
  include Oid::Controller::Helper

  private property _stop_app : Bool = false

  getter services : Oid::Services = Oid::Services.new(
    application: RayLib::ApplicationService.new,
    logger: RayLib::LoggerService.new,
    input: RayLib::InputService.new,
    config: RayLib::ConfigService.new(**RAYLIB_CONFIG),
    time: RayLib::TimeService.new,
    view: RayLib::ViewService.new,
    camera: RayLib::CameraService.new,
    window: RayLib::WindowService.new
  )

  def create_systems(contexts : Contexts)
    Entitas::Feature.new("Systems")
      .add(Oid::ServiceRegistrationSystems.new(contexts, services))
      .add(Oid::BaseSystems.new(contexts))
      .add(ExampleSystems.new(contexts))
  end
end

controller = AppController.new
controller.start

spawn do
  controller.start_server
end

window_controller = controller.contexts.app.window.value

while !window_controller.should_close?
  controller.update
  Fiber.yield
end

puts "DONE"
