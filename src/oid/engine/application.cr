module Oid
  abstract class Application
    protected setter contexts : Contexts? = nil
    @render_group : Entitas::Group(GameEntity)? = nil

    def contexts : Contexts
      raise "No contexts set" if @contexts.nil?
      @contexts.as(Contexts)
    end

    def config_service
      contexts.meta.config_service.instance
    end

    def view_service
      self.contexts.meta.view_service.instance
    end

    def camera : Oid::Camera
      self.contexts.game.camera.value
    end

    def render_group : Entitas::Group(GameEntity)
      @render_group ||= self.contexts.game.get_group(
        GameMatcher
          .all_of(GameMatcher.view, GameMatcher.position)
          .any_of(GameMatcher.asset, GameMatcher.actor)
          .none_of(GameMatcher.destroyed)
      )
    end

    abstract def should_close? : Bool

    # Window initialization and screens management
    # NOTE: Load resources (textures, fonts, audio) after Window initialization
    abstract def init(&block)

    # Update
    abstract def update(&block)

    # Draw
    abstract def draw(&block)

    # Draw
    abstract def draw_ui(&block)

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

        if self.camera.is_a?(Oid::Camera3D)
          self.view_service.set_camera_mode(self.camera.as(Oid::Camera3D))
        end
      end

      # Main game loop
      while !self.should_close?
        # Update
        self.update do
          controller.update
          update_hook.call(controller)

          # Update the camera
          self.view_service.update_camera(self.camera) if self.camera.target?
        end

        # Draw
        self.draw do
          # Pass each entity to the view service
          render_group.sort { |a, b| a.position.value.z <=> b.position.value.z }.each do |e|
            # render_group.each do |e|
            self.view_service.render(self.contexts, e)
          end

          draw_hook.call(controller)
        end

        self.draw_ui do
          if config_service.show_fps?
            self.view_service.render_fps
          end
        end

        Fiber.yield
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
