module RayLib
  module Camera
    def self.update(camera : RayLib::Camera3D) : Void
      binding = camera.to_unsafe
      RayLib::Binding.bg____UpdateCamera_STATIC_Camera_X(pointerof(binding))
    end
  end

  def self.trace_log(log_type : UInt32, text : String)
    trace_log(log_type.to_i, text)
  end

  def self.trace_log(log_type : RayLib::Enum::TraceLog, text : String)
    trace_log(log_type.value, text)
  end
end
