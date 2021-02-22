module Oid
  module Systems
    class CameraManager
      include Entitas::Systems::InitializeSystem
      include Entitas::Systems::ExecuteSystem
      include Oid::Services::Helper

      protected property contexts : Contexts
      protected property context : StageContext

      def initialize(@contexts)
        @context = contexts.stage
      end

      def init
        offset = config_service.camera_3d? ? Oid::Vector3.zero : Oid::Vector3.new(
          x: config_service.screen_w/2,
          y: config_service.screen_h/2,
          z: 0.0
        )

        # Initialize Camera
        camera = context.create_entity
          .add_camera(
            is_3d: config_service.camera_3d?,
            offset: offset,
            target: Oid::Vector3.zero,
          )

        if config_service.camera_3d?
          camera
            .add_rotation(Oid::Vector3.zero)
            .add_position(Oid::Vector3.new(x: 0.0, y: 0.0, z: 100.0))
            .add_position_type
        end

        if context.camera?
          entity = context.camera_entity.as(StageEntity)
          entity.add_rotation(Oid::Vector3.zero) unless entity.rotation?
          entity.add_position(Oid::Vector3.new(x: 0.0, y: 0.0, z: 0.0)) unless entity.position?
        end
      end

      def execute
        if context.camera? && context.camera_target? && context.camera_target_entity.as(StageEntity).position?
          entity = context.camera_entity.as(StageEntity)
          camera = entity.camera
          target = context.camera_target_entity.as(StageEntity)
          camera.target = target.transform

          # Update target position
          entity.replace_camera(camera)
        end
      end
    end
  end
end
