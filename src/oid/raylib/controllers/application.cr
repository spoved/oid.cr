class RayLib::ApplicationController
  include Oid::Controller::Application
  include Oid::Services::Helper

  getter contexts : ::Contexts

  def initialize(@contexts); end

  def init_application(contexts, entity, config_service : Oid::Service::Config)
  end

  def register_listeners(entity : Entitas::IEntity); end

  def init(&block)
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::ApplicationController - Starting Init")

    yield

    RayLib.set_target_fps(config_service.target_fps)
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::ApplicationController - End Init")
  end

  def update(&block)
    RayLib.trace_log(RayLib::Enum::TraceLog::Debug.value, "RayLib::Application - Starting Update")
    yield
    RayLib.trace_log(RayLib::Enum::TraceLog::Debug.value, "RayLib::Application - End Update")
  end

  def draw(&block)
    # RayLib.trace_log(RayLib::Enum::TraceLog::Debug.value, "RayLib::Application - Starting Draw")
    RayLib.begin_drawing
    RayLib.clear_background(Oid::Color::WHITE.to_unsafe)

    # self.view_service.begin_camera_mode

    yield

    # self.view_service.end_camera_mode
    # RayLib.trace_log(RayLib::Enum::TraceLog::Debug.value, "RayLib::Application - End Draw")
  end

  def draw_ui(&block)
    # RayLib.trace_log(RayLib::Enum::TraceLog::Debug.value, "RayLib::Application - Starting Draw UI")

    yield

    RayLib.end_drawing
    # RayLib.trace_log(RayLib::Enum::TraceLog::Debug.value, "RayLib::Application - End Draw UI")
  end

  def cleanup(&block)
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::Application - Starting Cleanup")
    yield
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::Application - End Cleanup")
  end

  def exit(&block)
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::Application - Starting Exit")
    yield
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::Application - End Exit")
  end
end
