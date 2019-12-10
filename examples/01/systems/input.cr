module Oid
  module Systems
    class Input
      include Entitas::Systems::ExecuteSystem
      include Entitas::Systems::CleanupSystem

      protected property contexts : Contexts
      protected property context : InputContext
      protected property keyboard_group : Entitas::Group(InputEntity)

      def initialize(@contexts)
        @context = @contexts.input
        @keyboard_group = @contexts.input.get_group(InputMatcher
          .all_of(InputMatcher.keyboard)
          .any_of(
            InputMatcher.key_up,
            InputMatcher.key_down,
            InputMatcher.key_pressed,
            InputMatcher.key_released
          ))
      end

      def execute
        # Check keyboard
        keyboard_group.each do |entity|
          if entity.keyboard.key == Oid::Enum::Key::B && entity.key_pressed?
            context.burst_mode = !context.burst_mode?
          end
        end

        # Check mouse
        if context.burst_mode?
          # If burst mode is enbaled then check `mouse_down`
          if context.left_mouse_entity.as(InputEntity).mouse_down?
            context.create_entity.add_input(context.left_mouse_entity.as(InputEntity).mouse_down.position)
          end
        else
          # If burst mode is disabled then check `mouse_pressed`
          if context.left_mouse_entity.as(InputEntity).mouse_pressed?
            context.create_entity.add_input(context.left_mouse_entity.as(InputEntity).mouse_pressed.position)
          end
        end
      end

      def cleanup
        context.entities.each do |e|
          if e.input?
            e.destroy
          end
        end
      end
    end
  end
end
