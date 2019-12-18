class RayLib::TimeService
  include Oid::Service::Time

  # Set target FPS (maximum)
  def target_fps=(value : Int32?)
    RayLib.set_target_fps(value)
  end

  # Returns current FPS
  def fps : Int32
    RayLib.get_fps.to_f64
  end

  # Returns time in seconds for last frame drawn
  def frame_time : Float64
    RayLib.get_frame_time.to_f64
  end

  # Returns elapsed time in seconds since InitWindow()
  def time : Float64
    RayLib.get_time.to_f64
  end

  # Returns the difference between `#time` and `#frame_time`
  def delta_time : Float64
    (RayLib.get_time - RayLib.get_frame_time).to_f64
  end
end
