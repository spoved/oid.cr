require "../../components/input"

module Oid
  module Systems
    class EmitInput
      include Entitas::Systems::InitializeSystem
      include Entitas::Systems::ExecuteSystem

      protected property context : InputContext
      protected setter left_mouse_entity : InputEntity? = nil
      protected setter right_mouse_entity : InputEntity? = nil
      protected setter keyboard_entity : InputEntity? = nil

      def left_mouse_entity : InputEntity
        @left_mouse_entity ||= context.left_mouse_entity.as(InputEntity)
      end

      def right_mouse_entity : InputEntity
        @right_mouse_entity ||= context.right_mouse_entity.as(InputEntity)
      end

      def keyboard_entity : InputEntity
        @keyboard_entity ||= context.keyboard_entity.as(InputEntity)
      end

      def self.new(contexts : Contexts)
        EmitInput.new(contexts.input)
      end

      def initialize(@context); end

      def init
        # Initialize unique entities for the context
        context.is_left_mouse = true
        self.left_mouse_entity = context.left_mouse_entity
        context.is_right_mouse = true
        self.right_mouse_entity = context.right_mouse_entity
        context.is_keyboard = true
        self.keyboard_entity = context.keyboard_entity
      end

      private def get_mouse_state(button)
        {
          down:     RayLib.is_mouse_button_down(button),
          up:       RayLib.is_mouse_button_up(button),
          pressed:  RayLib.is_mouse_button_pressed(button),
          released: RayLib.is_mouse_button_released(button),
        }
      end

      private def get_key_state(key : RayLib::Enum::Key)
        {
          key:      key,
          down:     RayLib.key_down?(key),
          up:       RayLib.key_up?(key),
          pressed:  RayLib.key_pressed?(key),
          released: RayLib.key_released?(key),
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

      def execute
        if Oid::Config.settings.enable_mouse
          position = RayLib.get_mouse_position

          # Left button
          emit_mouse(left_mouse_entity, position, get_mouse_state(0))

          # Right button
          emit_mouse(right_mouse_entity, position, get_mouse_state(1))
        end

        if Oid::Config.settings.enable_keyboard
          {% begin %}
            {% for key in RayLib::Enum::Key.constants %}
              emit_key(keyboard_entity, position, get_key_state(RayLib::Enum::Key::{{key.id}}))
            {% end %}
          {% end %}
        end
      end
    end
  end
end
