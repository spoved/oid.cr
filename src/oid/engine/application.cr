module Oid
  abstract class Application
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
    abstract def exit

    def start(controller)
      # Initialization
      self.init do
        controller.start
      end

      # Main game loop
      while !self.should_close?
        # Update
        self.update do
          controller.update
        end

        # Draw
        self.draw do
          # TODO
        end
      end

      # de-init
      self.cleanup do
        # TODO
      end

      self.exit
    end
  end
end
