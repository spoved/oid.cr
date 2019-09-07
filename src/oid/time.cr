module Oid
  module Time
    extend self

    def delta_time
      RayLib.get_time - RayLib.get_frame_time
    end
  end
end
