require "../../src/oid"
require "../../src/oid/raylib/*"
require "../helpers/*"
require "./systems/*"

::Log.builder.clear
spoved_logger(:debug, bind: true)

RAYLIB_CONFIG = {
  app_name:            "Eample 01",
  screen_w:            800,
  screen_h:            600,
  target_fps:          120,
  show_fps:            true,
  enable_mouse:        true,
  enable_keyboard:     true,
  asset_path:          "./examples/assets",
  board_size:          Oid::Vector2.new(10, 10),
  blocker_probability: 0.1,
  camera_mode:         "2d",
}

Oid::Systems::EmitInput.listen_for_keys(B)

create_feature Example, [
  Example::InputSystem,
  Example::BoardSystem,
  # ////////////////////////////////////////////////////
  # TODO: Place any services created here
  # ////////////////////////////////////////////////////
]

class ExampleConfigService < RayLib::ConfigService
  add_settings(
    board_size : Oid::Vector2 = Oid::Vector2.new(10, 10),
    blocker_probability : Float64 = 0.1,
  )
end

class AppController < Entitas::Controller
  getter services : Oid::Services = Oid::Services.new(
    application: RayLib::ApplicationService.new,
    logger: RayLib::LoggerService.new,
    input: RayLib::InputService.new,
    config: ExampleConfigService.new(**RAYLIB_CONFIG),
    time: RayLib::TimeService.new,
    view: RayLib::ViewService.new,
    camera: RayLib::CameraService.new,
    window: RayLib::WindowService.new
  )

  def create_systems(contexts : Contexts)
    Entitas::Feature.new("Systems")
      .add(Oid::ServiceRegistrationSystems.new(contexts, services))
      .add(OidSystems.new(contexts))
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
