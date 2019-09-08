require "../../src/oid"
require "./controller"

# IMAGE_PATH = File.join(__DIR__, "Bee.png")
ASSET_PATH = __DIR__

Oid.new_window(title: "Example: tut_02")

controller = GameController.new

class GameActor
  include Oid::Actor
end

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
