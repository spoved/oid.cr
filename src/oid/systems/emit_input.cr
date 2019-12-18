module Oid
  module Systems
    class EmitInput
      macro listen_for_keys(*args)

        class Oid::Systems::EmitInput
          KEYS = [
            {% for arg in args %}
            Oid::Enum::Key::{{arg.id}},
            {% end %}
          ]

          private def _listen_for_keys : Array(Oid::Enum::Key)
            KEYS
          end

          private def _init_keyboard_entites
            KEYS.each do |key|
              puts "Create entity for #{key}"
              context.create_entity
                .add_keyboard(key)
            end
          end
        end
      end

      include Entitas::Systems::InitializeSystem
      include Entitas::Systems::ExecuteSystem
      include Entitas::Systems::CleanupSystem
      include Oid::Services::Helper

      protected property contexts : Contexts
      protected property context : InputContext

      protected setter left_mouse_entity : InputEntity? = nil
      protected setter right_mouse_entity : InputEntity? = nil
      protected setter mouse_wheel_entity : InputEntity? = nil

      protected getter keyboard_group : Entitas::Group(InputEntity)

      def initialize(@contexts)
        @context = @contexts.input
        @keyboard_group = @contexts.input.get_group(
          InputMatcher.all_of(InputMatcher.keyboard)
        )
      end

      def left_mouse_entity : InputEntity
        @left_mouse_entity ||= context.left_mouse_entity.as(InputEntity)
      end

      def right_mouse_entity : InputEntity
        @right_mouse_entity ||= context.right_mouse_entity.as(InputEntity)
      end

      def mouse_wheel_entity : InputEntity
        @mouse_wheel_entity ||= context.mouse_wheel_entity.as(InputEntity)
      end

      def init
        # Initialize unique entities for the context
        context.left_mouse = true
        self.left_mouse_entity = context.left_mouse_entity
        context.right_mouse = true
        self.right_mouse_entity = context.right_mouse_entity
        self.mouse_wheel_entity = context.create_entity.add_mouse_wheel(move: 0)

        _init_keyboard_entites
      end

      def execute
        if config_service.enable_mouse?
          position = input_service.mouse_position

          # Left button
          emit_mouse(left_mouse_entity, position, get_mouse_state(0))

          # Right button
          emit_mouse(right_mouse_entity, position, get_mouse_state(1))

          wheel_move = input_service.mouse_wheel_move
          if wheel_move == 0 && self.mouse_wheel_entity.mouse_wheel.move == 0
            # Do nothing
          else
            self.mouse_wheel_entity.replace_mouse_wheel(move: wheel_move)
          end
        end

        if config_service.enable_keyboard?
          keyboard_group.each do |entity|
            emit_key(entity, position)
          end
        end

        # TODO: Implement touch
      end

      def cleanup
        left_mouse_entity.del_mouse_down if left_mouse_entity.mouse_down?
        left_mouse_entity.del_mouse_up if left_mouse_entity.mouse_up?
        left_mouse_entity.del_mouse_pressed if left_mouse_entity.mouse_pressed?
        left_mouse_entity.del_mouse_released if left_mouse_entity.mouse_released?

        right_mouse_entity.del_mouse_down if right_mouse_entity.mouse_down?
        right_mouse_entity.del_mouse_up if right_mouse_entity.mouse_up?
        right_mouse_entity.del_mouse_pressed if right_mouse_entity.mouse_pressed?
        right_mouse_entity.del_mouse_released if right_mouse_entity.mouse_released?

        keyboard_group.each do |entity|
          entity.del_key_down if entity.key_down?
          entity.del_key_up if entity.key_up?
          entity.del_key_pressed if entity.key_pressed?
          entity.del_key_released if entity.key_released?
        end
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

      private def get_key_state(key : Oid::Enum::Key)
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

      private def emit_key(entity : InputEntity, position : Oid::Vector2?)
        key = entity.keyboard.key
        state = get_key_state(key)

        entity.replace_position(position.to_v3) unless position.nil?

        if state[:down]
          entity.replace_key_down
        end

        if state[:up]
          entity.replace_key_up
        end

        if state[:pressed]
          entity.replace_key_pressed
        end

        if state[:released]
          entity.replace_key_released
        end
      end

      private def _listen_for_keys : Array(Oid::Enum::Key)
        raise "EmitInput _listen_for_keys is undefined"
      end

      private def _init_keyboard_entites
      end
    end
  end
end
