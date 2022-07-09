abstract class Example::AppController < Entitas::Controller
  include Oid::Controller::Helper
  private property _stop_app : Bool = false
  getter services : Oid::Services = Oid::Services.new(
    application: RayLib::ApplicationService.new,
    logger: RayLib::LoggerService.new,
    input: RayLib::InputService.new,
    config: RayLib::ConfigService.new(**RAYLIB_CONFIG),
    time: RayLib::TimeService.new,
    view: RayLib::ViewService.new,
    camera: RayLib::CameraService.new,
    window: RayLib::WindowService.new
  )

  abstract def create_systems(contexts : Contexts)
end
