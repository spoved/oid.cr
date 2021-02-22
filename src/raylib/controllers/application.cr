class RayLib::ApplicationController
  include Oid::Controller::Application
  include Oid::Services::Helper
  include Oid::Controller::Helper

  getter contexts : ::Contexts

  def initialize(@contexts)
    # FIXME: Doesnt actually work.
    RayLib.set_window_position(
      x: (RayLib.get_screen_width/2 - config_service.screen_w/2).to_i,
      y: (RayLib.get_screen_height/2 - config_service.screen_h/2).to_i,
    )
  end

  def init_application(contexts, entity, config_service : Oid::Service::Config); end

  def register_listeners(entity : Entitas::IEntity); end

  def init(&block)
    RayLib.trace_log(RayLib::Enum::TraceLog::Info, "RayLib::ApplicationController - Starting Init")

    yield

    RayLib.set_target_fps(config_service.target_fps)
    RayLib.trace_log(RayLib::Enum::TraceLog::Info, "RayLib::ApplicationController - End Init")
  end

  def update(&block)
    RayLib.trace_log(RayLib::Enum::TraceLog::Debug, "RayLib::Application - Starting Update")
    yield
    RayLib.trace_log(RayLib::Enum::TraceLog::Debug, "RayLib::Application - End Update")
  end

  def draw(&block)
    # RayLib.trace_log(RayLib::Enum::TraceLog::Debug, "RayLib::Application - Starting Draw")

    RayLib.begin_drawing
    RayLib.clear_background(Oid::Color::WHITE.to_unsafe)

    yield

    # RayLib.trace_log(RayLib::Enum::TraceLog::Debug, "RayLib::Application - End Draw")
  end

  def draw_ui(&block)
    # RayLib.trace_log(RayLib::Enum::TraceLog::Debug, "RayLib::Application - Starting Draw UI")

    yield

    RayLib.end_drawing
    # RayLib.trace_log(RayLib::Enum::TraceLog::Debug, "RayLib::Application - End Draw UI")
  end

  def cleanup(&block)
    RayLib.trace_log(RayLib::Enum::TraceLog::Info, "RayLib::Application - Starting Cleanup")
    yield
    RayLib.trace_log(RayLib::Enum::TraceLog::Info, "RayLib::Application - End Cleanup")
  end

  def exit(&block)
    RayLib.trace_log(RayLib::Enum::TraceLog::Info, "RayLib::Application - Starting Exit")
    yield
    RayLib.trace_log(RayLib::Enum::TraceLog::Info, "RayLib::Application - End Exit")
  end
end
