class RayLib::Application < Oid::Application
  property title : String

  def initialize(@title : String); end

  def should_close? : Bool
    RayLib.window_should_close
  end

  def config(&block)
    yield
  end

  def init(&block)
    yield

    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::Application - Starting Init")
    RayLib.init_window(
      config_service.screen_w,
      config_service.screen_h,
      title
    )
    RayLib.set_target_fps(config_service.target_fps)
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::Application - End Init")
  end

  def update(&block)
    # RayLib.trace_log(RayLib::Enum::TraceLog::Debug.value, "RayLib::Application - Starting Update")
    yield
    # RayLib.trace_log(RayLib::Enum::TraceLog::Debug.value, "RayLib::Application - End Update")
  end

  def draw(&block)
    # RayLib.trace_log(RayLib::Enum::TraceLog::Debug.value, "RayLib::Application - Starting Draw")
    RayLib.begin_drawing
    RayLib.clear_background(Oid::Color::WHITE.to_unsafe)
    yield
    RayLib.end_drawing
    # RayLib.trace_log(RayLib::Enum::TraceLog::Debug.value, "RayLib::Application - End Draw")
  end

  def cleanup(&block)
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::Application - Starting Cleanup")
    yield
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::Application - End Cleanup")
  end

  def exit(&block)
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::Application - Starting Exit")
    yield
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::Application - Closing window!!!!")
    RayLib.close_window
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::Application - End Exit")
  end
end
