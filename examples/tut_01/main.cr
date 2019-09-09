require "../../src/oid"
require "./controller"

Oid::Config.configure do |settings|
  settings.asset_dir = __DIR__
  settings.enable_mouse = true
  settings.enable_keyboard = true
  settings.show_fps = true
end

Oid.new_window(title: "Example: tut_01")

controller = GameController.new

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
