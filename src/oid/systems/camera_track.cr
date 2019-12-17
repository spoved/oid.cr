module Oid
  module Systems
    class CameraTrack
      include Entitas::Systems::ExecuteSystem

      protected property contexts : Contexts
      protected property context : StageContext? = nil

      def initialize(@contexts)
        @context = contexts.scene
      end

      def execute
        if context.camera? && context.camera_target? && context.camera_target_entity.position?
          context.camera_entity.replace_position(context.camera_target_entity.position)
        end
      end
    end
  end
end
