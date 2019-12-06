module Oid
  abstract class Application
    protected setter contexts : Contexts? = nil

    def contexts : Contexts
      raise "No contexts set" if @contexts.nil?
      @contexts.as(Contexts)
    end

    def config_service
      contexts.meta.config_service.instance
    end

    abstract def should_close? : Bool

    # Window initialization and screens management
    # NOTE: Load resources (textures, fonts, audio) after Window initialization
    abstract def init(&block)

    # Update
    abstract def update(&block)

    # Draw
    abstract def draw(&block)

    # De-Initialization
    # NOTE: Unload any loaded resources (texture, fonts, audio)
    abstract def cleanup(&block)

    # Close window and OpenGL context
    abstract def exit(&block)

    def start(controller : Entitas::Controller,
              init_hook : Proc(Entitas::Controller, _) = ->(cont : Entitas::Controller) {},
              update_hook : Proc(Entitas::Controller, _) = ->(cont : Entitas::Controller) {},
              draw_hook : Proc(Entitas::Controller, _) = ->(cont : Entitas::Controller) {},
              cleanup_hook : Proc(Entitas::Controller, _) = ->(cont : Entitas::Controller) {},
              exit_hook : Proc(Entitas::Controller, _) = ->(cont : Entitas::Controller) {})
      controller.start
      self.contexts = controller.contexts

      # Initialization
      self.init do
        init_hook.call(controller)
      end

      # Gather the render group
      render_group = self.contexts.game.get_group(
        GameMatcher
          .all_of(GameMatcher.view, GameMatcher.position, GameMatcher.asset)
          .none_of(GameMatcher.destroyed)
      )

      # Main game loop
      while !self.should_close?
        # Update
        self.update do
          controller.update
          update_hook.call(controller)
        end

        # Draw
        self.draw do
          # Pass each entity to the view service
          render_group.each do |e|
            if e.view?
              self.contexts.meta.view_service.instance.render(self.contexts, e)
            end
          end

          draw_hook.call(controller)
        end
      end

      # de-init
      self.cleanup do
        cleanup_hook.call(controller)
      end

      self.exit do
        exit_hook.call(controller)
      end
    end
  end
end
