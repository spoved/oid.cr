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
    end
  end
end
