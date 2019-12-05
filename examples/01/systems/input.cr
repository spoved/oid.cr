module Oid
  module Systems
    class Input
      include Entitas::Systems::ExecuteSystem
      include Entitas::Systems::CleanupSystem

      protected property contexts : Contexts
      protected property context : InputContext

      def initialize(@contexts)
        @context = @contexts.input
      end

      def execute
        # Check keyboard
        if context.keyboard_entity.as(InputEntity) && context.keyboard_entity.as(InputEntity).key_pressed?
          # Check if we need to enable burst mode
          if context.keyboard_entity.as(InputEntity).key_pressed.value == Oid::Enum::Key::B
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
