module Oid
  module Service
    module Camera
      include Oid::Service

      abstract def set_camera_mode(mode : Oid::Camera::Mode)
      abstract def update_camera(entity : StageEntity)

      abstract def begin_camera_mode
      abstract def end_camera_mode
    end
  end
end
