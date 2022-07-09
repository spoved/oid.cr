require "../../src/oid"
require "../../src/raylib"
require "../helpers/*"
require "./systems/**"

RAYLIB_CONFIG = {
  app_name:        "Example 06",
  screen_w:        800,
  screen_h:        450,
  target_fps:      60,
  show_fps:        true,
  enable_mouse:    true,
  enable_keyboard: true,
  camera_mode:     "2d",
  asset_path:      "./examples/assets",
}

create_feature Example, [
  Example::InputSystem,
  Example::WorldSystem,
  # ////////////////////////////////////////////////////
  # TODO: Place any services created here
  # ////////////////////////////////////////////////////
]

class AppController < Example::AppController
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
