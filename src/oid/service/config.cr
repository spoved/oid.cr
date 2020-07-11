module Oid
  module Service
    module Config
      include Oid::Service

      def resolution : Tuple(Int32, Int32)
        {screen_w, screen_h}
      end

      abstract def screen_w : Int32

      abstract def screen_h : Int32

      abstract def target_fps : Int32

      abstract def show_fps? : Bool

      abstract def enable_mouse? : Bool

      abstract def enable_keyboard? : Bool

      abstract def camera_3d? : Bool

      def configure
        yield self
      end

      macro add_settings(*args)
        {% for a in args %}
        getter {{a}}
        {% end %}
      end
    end
  end
end
