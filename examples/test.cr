require "../src/oid"
require "../src/oid/raylib/systems"
require "spoved"
require "entitas"

class DebugLogService
  include Oid::Service::Logger
  spoved_logger

  def log(msg : String)
    logger.info(msg)
  end
end

class ConfigService
  include Oid::Service::Config

  def enable_mouse? : Bool
    true
  end

  def enable_keyboard? : Bool
    false
  end
end

class GameController < Entitas::Controller
  getter services = Services.new(
    logger: DebugLogService.new,
    input: RayLib::InputSystem.new,
    config: ConfigService.new,
  )

  def create_systems(contexts : Contexts)
    Entitas::Feature.new("Systems")
      .add(ServiceRegistrationSystems.new(contexts, services))
      .add(Oid::Systems::EmitInput.new(contexts))
  end
end

controller = GameController.new

RayLib.init_window(800, 600, "TEST")
RayLib.set_target_fps(120)

spawn do
  while !RayLib.window_should_close
    RayLib.begin_drawing

    RayLib.clear_background(Oid::Color::WHITE.to_unsafe)
    RayLib.draw_fps(10, 10)

    controller.update

    RayLib.end_drawing
  end
end

RayLib.unhide_window
controller.start

while !RayLib.window_should_close
  Fiber.yield
end
