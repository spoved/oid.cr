require "../raylib/color"

@[Component::Unique]
@[Context(Global)]
class Oid::Window
  spoved_logger

  prop :x, Int32, default: 800
  prop :y, Int32, default: 600
  prop :title, String, default: "Oid Window"
  prop :background_color, RayLib::Color, default: RayLib::Color::WHITE

  # Initialize window and OpenGL context
  def open
    logger.info("activating window", self)
    RayLib.init_window(x, y, title)
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
  def minimized?
    RayLib.is_window_minimized
  end

  # Check if window has been resized
  def resized?
    RayLib.is_window_resized
  end

  # Check if window is currently hidden
  def hidden?
    RayLib.is_window_hidden
  end

  # Check if window is currently visable
  def visable?
    !self.hidden?
  end

  # Hide the window
  def hide
    logger.info("hide window", self)
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
    io << "Oid::Window(" << self.title << ")"
  end
end
