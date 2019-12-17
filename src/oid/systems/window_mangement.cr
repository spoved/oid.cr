module Oid
  module Systems
    class WindowMangement
      include Entitas::Systems::InitializeSystem

      protected property contexts : Contexts
      protected getter context : AppContext

      def initialize(@contexts)
        @context = @contexts.app
      end

      def window_service
        contexts.meta.window_service.instance
      end

      def window_entity : AppEntity
        context.window_entity
      end

      def window_controller : Oid::Controller::Window
        context.window.value
      end

      def config_service
        contexts.meta.config_service.instance
      end

      def init
        if context.window_entity?
          raise "A Window Entity already exists!"
        else
          # Create our window entity
          entity = context.create_entity.add_window(window_service.init_controller(contexts))

          # Initialize our window
          window_controller.init_window(contexts, entity, config_service)
        end
      end
    end
  end
end
