require "../../src/oid"
require "../../src/oid/raylib/**"

RAYLIB_CONFIG = {
  screen_w:        800,
  screen_h:        600,
  target_fps:      120,
  show_fps:        false,
  enable_mouse:    true,
  enable_keyboard: true,
  asset_path:      "",
}

class AppController < Entitas::Controller
  getter services : Oid::Services = Oid::Services.new(
    # application: ApplicationService.new,
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
      .add(Stage::EventSystems.new(contexts))
      .add(OidSystems.new(contexts))
  end
end

controller = AppController.new
controller.start

100.times do
  controller.update
end

puts "DONE"
