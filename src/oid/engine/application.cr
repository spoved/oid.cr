module Oid
  abstract class Application
    private setter controller : Entitas::Controller? = nil

    def controller : Entitas::Controller
      if @controller.nil?
        raise "No controller set for the application"
      end
      @controller.as(Entitas::Controller)
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

    def start(cont : Entitas::Controller,
              init_hook : Proc(Entitas::Controller, _) = ->(cont : Entitas::Controller) {},
              update_hook : Proc(Entitas::Controller, _) = ->(cont : Entitas::Controller) {},
              draw_hook : Proc(Entitas::Controller, _) = ->(cont : Entitas::Controller) {},
              cleanup_hook : Proc(Entitas::Controller, _) = ->(cont : Entitas::Controller) {},
              exit_hook : Proc(Entitas::Controller, _) = ->(cont : Entitas::Controller) {})
      self.controller = cont

      # Initialization
      self.init do
        self.controller.start
        init_hook.call(self.controller)
      end

      # Main game loop
      while !self.should_close?
        # Update
        self.update do
          self.controller.update
          update_hook.call(self.controller)
        end

        # Draw
        self.draw do
          draw_hook.call(self.controller)
        end
      end

      # de-init
      self.cleanup do
        cleanup_hook.call(self.controller)
      end

      self.exit do
        exit_hook.call(self.controller)
      end
    end
  end
end
