module Oid
  module Systems
    class Application
      include Oid::Services::Helper

      include Entitas::Systems::InitializeSystem
      include Entitas::Systems::ExecuteSystem
      include Oid::Components::Destroyed::Listener

      protected property contexts : Contexts
      protected getter context : AppContext
      private setter render_group : Entitas::Group(StageEntity)? = nil
      private setter ui_render_group : Entitas::Group(StageEntity)? = nil

      def renderable_entities : Entitas::Group(StageEntity)
        @render_group ||= contexts.stage.get_group(
          StageMatcher.all_of(
            StageMatcher.view,
            StageMatcher.position,
            StageMatcher.position_type,
            StageMatcher.rotation,
            StageMatcher.scale,
          ).none_of(
            StageMatcher.destroyed,
            StageMatcher.ui_element,
            StageMatcher.hidden,
          )
        )
      end

      def ui_renderable_entities : Entitas::Group(StageEntity)
        @ui_render_group ||= contexts.stage.get_group(
          StageMatcher.all_of(
            StageMatcher.view,
            StageMatcher.position,
            StageMatcher.position_type,
            StageMatcher.rotation,
            StageMatcher.scale,
            StageMatcher.ui_element,
          ).none_of(
            StageMatcher.destroyed,
            StageMatcher.hidden,
          )
        )
      end

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

          # Create root_view object
          view_service.get_root_view(contexts)
        end

        application_controller.init do
          application_service.init_hook.call(contexts)

          if contexts.stage.camera? && contexts.stage.camera.is_3d
            camera_service.update_camera(contexts.stage.camera_entity)
            camera_service.set_camera_mode(contexts.stage.camera.mode)
          end
        end
      end

      def execute
        unless application_entity.destroyed?
          # # Update the transform of each item
          # renderable_entities.each &.calculate_transform

          application_controller.update do
            application_service.update_hook.call(contexts)

            # Update camera
            camera_service.update_camera(contexts.stage.camera_entity)
          end

          application_controller.draw do
            camera_service.begin_camera_mode
            application_service.draw_hook.call(contexts, renderable_entities)
            camera_service.end_camera_mode
          end

          application_controller.draw_ui do
            application_service.draw_ui_hook.call(contexts, ui_renderable_entities)
            application_service.render_fps if config_service.show_fps?
          end
        end

        Fiber.yield
      end

      def on_destroyed(entity, component : Oid::Components::Destroyed)
        application_controller.cleanup do
          application_service.cleanup_hook.call(contexts)
        end

        application_controller.exit do
          application_service.exit_hook.call(contexts)
        end
      end
    end
  end
end
