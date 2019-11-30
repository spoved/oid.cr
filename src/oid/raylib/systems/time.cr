class RayLib::TimeSystem
  include Oid::Service::Time

  # Set target FPS (maximum)
  def target_fps=(value : Int32?)
    RayLib.set_target_fps(value)
  end

  # Returns current FPS
  def fps : Int32
    RayLib.get_fps
  end

  # Returns time in seconds for last frame drawn
  def frame_time : Float64
    RayLib.get_frame_time
  end

  # Returns elapsed time in seconds since InitWindow()
  def time : Float64
    RayLib.get_time
  end
end
