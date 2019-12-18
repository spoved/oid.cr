module Oid
  module Systems
    class Application
      include Oid::Services::Helper

      include Entitas::Systems::InitializeSystem
      include Entitas::Systems::ExecuteSystem
      include Oid::Destroyed::Listener

      protected property contexts : Contexts
      protected getter context : AppContext

      def initialize(@contexts)
        @context = @contexts.app
      end

      def application_entity : AppEntity
        context.application_entity
      end

      def application_controller : Oid::Controller::Application
        context.application.value
      end

      def init
        if context.application_entity?
          raise "A application Entity already exists!"
        else
          # Create our application entity
          entity = context.create_entity.add_application(application_service.init_controller(contexts))

          # Initialize our application
          application_controller.init_application(contexts, entity, config_service)

          # Add destroyed listener
          entity.add_destroyed_listener(self)
        end

        application_controller.init do
          application_service.init_hook.call(application_controller)
        end
      end

      def execute
        unless application_entity.destroyed?
          application_controller.update do
            application_service.update_hook.call(application_controller)
          end

          application_controller.draw do
            application_service.draw_hook.call(application_controller)
          end

          application_controller.draw_ui do
            application_service.draw_ui_hook.call(application_controller)
          end
        end

        Fiber.yield
      end

      def on_destroyed(entity, component : Oid::Destroyed)
        application_controller.cleanup do
          application_service.cleanup_hook.call(application_controller)
        end

        application_controller.exit do
          application_service.exit_hook.call(application_controller)
        end
      end
    end
  end
end
