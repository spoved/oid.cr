require "./color"

@[Component::Unique]
@[Context(Global)]
class Oid::Window
  spoved_logger

  define_property :x, Int32, default: 800
  define_property :y, Int32, default: 600
  define_property :title, String, default: "Oid Window"

  # Will activate the window
  def open
    logger.info("activating window", self)
    RayLib.init_window(x, y, title)
  end

  # Will close the window
  def close
    logger.info("closing window", self)
    RayLib.close_window
  end

  # Is the window hidden
  def hidden?
    RayLib.is_window_hidden
  end

  # Is the window visable
  def visable?
    !self.hidden?
  end

  # Check if KEY_ESCAPE pressed or Close icon pressed
  def should_close? : Bool
    RayLib.window_should_close
  end

  # Hide the window
  def hide!
    logger.info("hide window", self)
    RayLib.hide_window
  end

  # :nodoc:
  private def pre_render
    RayLib.begin_drawing
    RayLib.clear_background Oid::Color::WHITE
  end

  # :nodoc:
  private def post_render
    RayLib.end_drawing
  end

  def render(&block)
    # logger.info("rendering window", self)
    self.pre_render unless self.hidden?
    yield
    self.post_render unless self.hidden?
  end

  def start
    logger.info("starting window", self)

    while !self.should_close?
      render do
        Fiber.yield
      end
    end

    self.hide!
  end

  def to_s(io)
    io << "Oid::Window(" << self.title << ")"
  end
end
