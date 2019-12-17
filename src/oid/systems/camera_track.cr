module Oid
  module Systems
    class CameraTrack
      include Entitas::Systems::ExecuteSystem

      protected property contexts : Contexts
      protected property context : StageContext

      def initialize(@contexts)
        @context = contexts.stage
      end

      def execute
        if context.camera? && context.camera_target? && context.camera_target_entity.as(StageEntity).position?
          context.camera_entity.as(StageEntity).replace_position(
            context.camera_target_entity.as(StageEntity).position
          )
        end
      end
    end
  end
end
