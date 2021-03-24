require "../../src/oid"
require "../../src/raylib"
require "../helpers/*"

# Spoved.logger.level = Logger::DEBUG

RAYLIB_CONFIG = {
  app_name:        "Example 05",
  screen_w:        800,
  screen_h:        450,
  target_fps:      300,
  show_fps:        true,
  enable_mouse:    true,
  enable_keyboard: true,
  camera_mode:     "2d",
  asset_path:      "./examples/01/assets",
}

Oid::Systems::EmitInput.listen_for_keys A, S, D, W, Q

class AppService < RayLib::ApplicationService
  property toggle_group = 0

  def draw(contexts : Contexts, render_group : Entitas::Group(StageEntity))
    super
    self.toggle_group = RayLib::Gui.toggle_group(
      RayLib::Rectangle.new(141.0_f32, 144.0_f32, 41.0_f32, 25.0_f32),
      "ONE;TWO;THREE",
      self.toggle_group
    )
  end

  def draw_ui(contexts : Contexts, render_group : Entitas::Group(StageEntity))
    super
  end
end

#   def draw(contexts : Contexts, render_group : Entitas::Group(StageEntity))

class AppController < Entitas::Controller
  include Oid::Controller::Helper

  private property _stop_app : Bool = false

  getter services : Oid::Services = Oid::Services.new(
    application: AppService.new,
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