require "../../raylib/color"
require "../config"

module Oid
  # The `Oid::Window` class is the main viewport of your application/game.
  # By default it is stored in the `GlobalContext` and is a unique component.
  # You should always access it via the `Oid` module or `Contexts.global` context.
  #
  # ```
  # Oid.new_window(title: "Example Window")
  #
  # Oid.window                             # => Oid::Window(Example Window)
  # Oid.global_context.window              # => Oid::Window(Example Window)
  # Contexts.shared_instance.global.window # => Oid::Window(Example Window)
  # ```
  @[Component::Unique]
  @[Context(Global)]
  class Window
    spoved_logger

    prop :x, Int32, default: Oid::Config.settings.resolution[:x]
    prop :y, Int32, default: Oid::Config.settings.resolution[:y]
    prop :title, String, default: "Oid Window"
    prop :background_color, RayLib::Color, default: RayLib::Color::WHITE

    @to_string_cache : String? = nil

    # Initialize window and OpenGL context
    def open
      @to_string_cache = nil
      logger.info("activating window", self)

      if Oid::Config.settings.target_fps > 0
        RayLib.set_target_fps(Oid::Config.settings.target_fps)
      end

      RayLib.hide_cursor unless Oid::Config.settings.show_cursor
      RayLib.init_window(x, y, title)

      if Oid::Config.settings.fullscreen
        RayLib.toggle_fullscreen
      end
    end

    # Check if KEY_ESCAPE pressed or Close icon pressed
    def should_close? : Bool
      RayLib.window_should_close
    end

    # Close window and unload OpenGL context
    def close
      logger.info("closing window", self)
      RayLib.close_window
    end

    # Check if window has been initialized successfully
    def ready? : Bool
      RayLib.is_window_ready
    end

    # Check if window has been minimized (or lost focus)
    def minimized? : Bool
      RayLib.is_window_minimized
    end

    # Check if window has been resized
    def resized? : Bool
      RayLib.is_window_resized
    end

    # Check if window is currently hidden
    def hidden? : Bool
      RayLib.is_window_hidden
    end

    # Check if window is currently visable
    def visable? : Bool
      !self.hidden?
    end

    # Hide the window
    def hide
      logger.info("hide window", self)

      if Oid::Config.settings.fullscreen
        RayLib.toggle_fullscreen
      end

      RayLib.hide_window
    end

    # Show the window
    def show
      logger.info("show window", self)
      RayLib.unhide_window
    end

    # :nodoc:
    private def pre_render
      RayLib.begin_drawing
      RayLib.clear_background(self.background_color)

      if Oid::Config.settings.show_fps
        RayLib.draw_fps(10, 10)
      end
    end

    # :nodoc:
    private def post_render
      RayLib.end_drawing
    end

    def render
      # logger.info("rendering window", self)
      self.pre_render unless self.hidden?
      yield
      self.post_render unless self.hidden?
    end

    def start(&block)
      logger.info("starting window", self)

      while !self.should_close?
        render(&block)
      end

      self.hide
    end

    def screen_w : Int32
      RayLib.get_screen_width
    end

    def screen_h : Int32
      RayLib.get_screen_height
    end

    # :nodoc:
    def to_s(io)
      if @to_string_cache.nil?
        @to_string_cache = "Oid::Window(#{self.title}, x: #{self.x}, y: #{self.y})"
      end

      io << @to_string_cache
    end
  end
end
