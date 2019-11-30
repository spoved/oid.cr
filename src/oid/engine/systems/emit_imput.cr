module Oid
  module Systems
    class EmitInput
      include Entitas::Systems::InitializeSystem
      include Entitas::Systems::ExecuteSystem
      include Entitas::Systems::CleanupSystem

      protected property contexts : Contexts
      protected property context : InputContext

      protected setter config_service : Oid::Service::Config? = nil
      protected setter input_service : Oid::Service::Input? = nil

      protected setter left_mouse_entity : InputEntity? = nil
      protected setter right_mouse_entity : InputEntity? = nil
      protected setter keyboard_entity : InputEntity? = nil

      def initialize(@contexts)
        @context = @contexts.input
      end

      def left_mouse_entity : InputEntity
        @left_mouse_entity ||= context.left_mouse_entity.as(InputEntity)
      end

      def right_mouse_entity : InputEntity
        @right_mouse_entity ||= context.right_mouse_entity.as(InputEntity)
      end

      def keyboard_entity : InputEntity
        @keyboard_entity ||= context.keyboard_entity.as(InputEntity)
      end

      def config_service
        @config_service ||= contexts.meta.config_service.instance
      end

      def input_service
        @input_service ||= contexts.meta.input_service.instance
      end

      def init
        @input_service = contexts.meta.input_service.instance
        @config_service = contexts.meta.config_service.instance

        # Initialize unique entities for the context
        context.left_mouse = true
        self.left_mouse_entity = context.left_mouse_entity
        context.right_mouse = true
        self.right_mouse_entity = context.right_mouse_entity
        context.keyboard = true
        self.keyboard_entity = context.keyboard_entity
      end

      def execute
        if config_service.enable_mouse?
          position = input_service.mouse_position

          # Left button
          emit_mouse(left_mouse_entity, position, get_mouse_state(0))

          # Right button
          emit_mouse(right_mouse_entity, position, get_mouse_state(1))
        end

        if config_service.enable_keyboard?
          key = input_service.latest_key_pressed?

          unless key.nil?
            keyboard_entity.replace_key_pressed(value: key, position: position)
          end
        end

        # TODO: Implement touch
      end

      def cleanup
        # TODO: Implement
      end

      private def get_mouse_state(button)
        {
          button:   button,
          down:     input_service.mouse_button_down?(button),
          up:       input_service.mouse_button_up?(button),
          pressed:  input_service.mouse_button_pressed?(button),
          released: input_service.mouse_button_released?(button),
        }
      end

      private def get_key_state(key : Int32)
        {
          key:      key,
          down:     input_service.key_down?(key),
          up:       input_service.key_up?(key),
          pressed:  input_service.key_pressed?(key),
          released: input_service.key_released?(key),
        }
      end

      private def emit_mouse(entity, position, state)
        if state[:down]
          entity.replace_mouse_down(position: position)
        end

        if state[:up]
          entity.replace_mouse_up(position: position)
        end

        if state[:pressed]
          entity.replace_mouse_pressed(position: position)
        end

        if state[:released]
          entity.replace_mouse_released(position: position)
        end
      end

      private def emit_key(entity, position, state)
        if state[:down]
          entity.replace_key_down(value: state[:key], position: position)
        end

        if state[:up]
          entity.replace_key_up(value: state[:key], position: position)
        end

        if state[:pressed]
          entity.replace_key_pressed(value: state[:key], position: position)
        end

        if state[:released]
          entity.replace_key_released(value: state[:key], position: position)
        end
      end
    end
  end
end
