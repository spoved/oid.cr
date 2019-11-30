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
  end

  def update(&block)
    yield
  end

  def draw(&block)
    RayLib.trace_log(RayLib::Enum::TraceLog::Debug.value, "RayLib::Application - Starting Draw")
    RayLib.begin_drawing

    RayLib.clear_background(Oid::Color::WHITE.to_unsafe)
    RayLib.draw_fps(10, 10)

    yield

    RayLib.end_drawing
  end

  def cleanup(&block)
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::Application - Starting Cleanup")
    yield
  end

  def exit
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::Application - Starting Exit")
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::Application - Closing window!!!!")
    RayLib.close_window
  end
end
