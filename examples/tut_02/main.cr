require "../../src/oid"

create_controller Game, [
  MultiSystems,
  InputSystems,
  MovementSystems,
  RenderSystems,
  ViewSystems,
]

Oid::Config.configure do |settings|
  settings.asset_dir = File.join(__DIR__, "..", "tut_01")
  settings.enable_mouse = true
  settings.enable_keyboard = true
  settings.show_fps = true
  settings.target_fps = 120
end

Oid.new_window(title: "Example: tut_02")

controller = GameController.new
controller.start_server

# Start window fiber
spawn do
  controller.start

  Oid.window.start do
    controller.update
  end
end

# Yield to the window
while Oid.window.visable?
  Fiber.yield
end

Oid.global_context.destroy_all_entities
