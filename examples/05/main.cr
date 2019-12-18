require "../../src/oid"
require "../../src/oid/raylib/**"
require "./systems/**"

RAYLIB_CONFIG = {
  app_name:        "Example 05",
  screen_w:        800,
  screen_h:        600,
  target_fps:      120,
  show_fps:        false,
  enable_mouse:    true,
  enable_keyboard: true,
  asset_path:      "./examples/01/assets",
}

class AppController < Entitas::Controller
  private property _stop_app : Bool = false

  getter services : Oid::Services = Oid::Services.new(
    application: RayLib::ApplicationSystem.new,
    logger: RayLib::LoggerSystem.new,
    input: RayLib::InputSystem.new,
    config: RayLib::ConfigSystem.new(RAYLIB_CONFIG),
    time: RayLib::TimeSystem.new,
    view: RayLib::ViewSystem.new,
    camera: RayLib::CameraSystem.new,
    window: RayLib::WindowSystem.new
  )

  def create_systems(contexts : Contexts)
    Entitas::Feature.new("Systems")
      .add(Oid::ServiceRegistrationSystems.new(contexts, services))
      .add(OidSystems.new(contexts))
      .add(Example::WorldSystem.new(contexts))
  end

  def window_controller
    contexts.app.window.value
  end

  def app_controller
    contexts.app.window.value
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
