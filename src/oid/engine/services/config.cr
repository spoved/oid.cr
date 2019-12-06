require "habitat"

module Oid
  module Service
    module Config
      include Oid::Service

      macro add_settings(*args)
        Habitat.create do
          setting screen_w : Int32
          setting screen_h : Int32
          setting target_fps : Int32
          setting show_fps : Bool
          setting enable_mouse : Bool
          setting enable_keyboard : Bool

          {% for arg in args %}
          setting {{arg}}
          {% end %}
        end
      end

      def resolution : Tuple(Int32, Int32)
        {screen_w, screen_h}
      end

      abstract def screen_w : Int32

      abstract def screen_h : Int32

      abstract def target_fps : Int32

      abstract def show_fps? : Bool

      abstract def enable_mouse? : Bool

      abstract def enable_keyboard? : Bool
    end
  end
end
