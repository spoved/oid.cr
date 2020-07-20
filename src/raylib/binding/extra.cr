module RayLib
  module Camera
    def self.update(camera : RayLib::Camera3D) : Void
      binding = camera.to_unsafe
      RayLib::Binding.bg____UpdateCamera_STATIC_Camera_X(pointerof(binding))
    end
  end
end
