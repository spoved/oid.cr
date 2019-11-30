module Oid
  module Service
    module Time
      include Oid::Service

      # Set target FPS (maximum)
      abstract def target_fps=(value : Int32?)

      # Returns current FPS
      abstract def fps : Int32

      # Returns time in seconds for last frame drawn
      abstract def frame_time : Int32

      # Returns elapsed time in seconds since InitWindow()
      abstract def time : Int32
    end
  end
end
