require "./color"

module Oid
  class Window
    def initialize(x, y, title)
      RayLib.init_window x, y, title
    end

    def start
      while !RayLib.window_should_close
        render do
        end
      end
    end

    def render
      RayLib.begin_drawing
      RayLib.clear_background Oid::Color::WHITE

      yield

      RayLib.end_drawing
    end
  end
end
