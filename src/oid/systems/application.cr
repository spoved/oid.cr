module Oid
  module Systems
    class Application
      include Entitas::Systems::InitializeSystem
      include Entitas::Systems::ExecuteSystem

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

      def application_service : Oid::Service::Application
        contexts.meta.application_service.instance
      end

      def config_service : Oid::Service::Config
        contexts.meta.config_service.instance
      end

      def init
        if context.application_entity?
          raise "A application Entity already exists!"
        else
          # Create our application entity
          entity = context.create_entity.add_application(application_service.init_controller(contexts))

          # Initialize our application
          application_controller.init_application(contexts, entity, config_service)
        end

        application_controller.init do
          application_service.init_hook.call(application_controller)
        end
      end

      def execute
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

      # TODO: Call cleanup and exit when closing app
    end
  end
end
