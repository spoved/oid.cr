module Oid
  module Systems
    class EmitInput
      include Entitas::Systems::InitializeSystem
      include Entitas::Systems::ExecuteSystem
      include Entitas::Systems::CleanupSystem

      protected property contexts : Contexts
      protected property input_service : Oid::Service::Input? = nil

      def initialize(@contexts); end

      def init
        @input_service = contexts.meta.input_service.instance
      end

      def execute
        puts input_service.as(Oid::Service::Input).mouse_button_down?(1)
      end

      def cleanup
      end
    end
  end
end
