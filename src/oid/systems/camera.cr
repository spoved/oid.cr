module Oid
  module Systems
    class Camera
      include Entitas::Systems::InitializeSystem
      include Entitas::Systems::ExecuteSystem
      include Oid::Services::Helper

      protected property contexts : Contexts
      protected property context : StageContext

      def initialize(@contexts)
        @context = contexts.stage
      end

      def init
        # Initialize Camera
        context.create_entity
          .add_camera(
            is_3d: config_service.camera_3d?,
            offset: Oid::Vector3.new(
              config_service.screen_w/2,
              config_service.screen_h/2,
              0.0
            )
          )
          .add_position(Oid::Vector3.zero)

        if context.camera?
          entity = context.camera_entity.as(StageEntity)
          entity.add_rotation(Oid::Vector3.zero) unless entity.rotation?
        end
      end

      def execute
        if context.camera? && context.camera_target? && context.camera_target_entity.as(StageEntity).position?
          entity = context.camera_entity.as(StageEntity)
          entity.add_rotation(Oid::Vector3.zero) unless entity.rotation?

          target = context.camera_target_entity.as(StageEntity)

          if entity.camera.is_2d?
            prev_target_pos = entity.camera.target
            new_target_pos = target.position.value
            offset = (new_target_pos - prev_target_pos)
            entity.camera.offset = entity.camera.offset - offset
          end

          # Update target position
          entity.camera.target = target.position.value
        end
      end
    end
  end
end
