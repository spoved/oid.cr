require "../../src/oid"
require "./controller"

# RayLib.set_config_flags(RayLib::Enum::Config::WindowResizable.value.to_u8)

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
