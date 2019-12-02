class RayLib::Application < Oid::Application
  property title : String
  property screen_w : Int32
  property screen_h : Int32
  property target_fps : Int32

  def initialize(@title : String, @screen_w : Int32 = 800, @screen_h : Int32 = 600, @target_fps : Int32 = 120); end

  def should_close? : Bool
    RayLib.window_should_close
  end

  def init(&block)
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::Application - Starting Init")
    RayLib.init_window(screen_w, screen_h, title)
    RayLib.set_target_fps(target_fps)
    yield
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
