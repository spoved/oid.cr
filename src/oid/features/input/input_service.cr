module Oid
  module Service
    module InputService
      include Oid::Service

      # # Input-related functions: keyboard

      # Detect if a key has been pressed once
      abstract def key_pressed?(key : Oid::Enum::Key) : Bool

      # Detect if a key is being pressed
      abstract def key_down?(key : Oid::Enum::Key) : Bool

      # Detect if a key has been released once
      abstract def key_released?(key : Oid::Enum::Key) : Bool

      # Detect if a key is NOT being pressed
      abstract def key_up?(key : Oid::Enum::Key) : Bool

      # Get latest key pressed
      abstract def latest_key_pressed? : Oid::Enum::Key?

      # # Input-related functions: mouse

      # Detect if a mouse button has been pressed once
      abstract def mouse_button_pressed?(button) : Bool

      # Detect if a mouse button is being pressed
      abstract def mouse_button_down?(button) : Bool

      # Detect if a mouse button has been released once
      abstract def mouse_button_released?(button) : Bool

      # Detect if a mouse button is NOT being pressed
      abstract def mouse_button_up?(button) : Bool

      # Returns mouse position X
      abstract def mouse_x : Float64

      # Returns mouse position Y
      abstract def mouse_y : Float64

      # Returns mouse position XY
      abstract def mouse_position : Oid::Vector2

      # Returns mouse wheel move
      abstract def mouse_wheel_move : Int32

      # # Input-related functions: touch

      # Returns touch position X for touch point 0 (relative to screen size)
      abstract def touch_x : Float64

      # Returns touch position Y for touch point 0 (relative to screen size)
      abstract def touch_y : Float64

      # Returns touch position XY for a touch point index (relative to screen size)
      abstract def touch_position : Oid::Vector2
    end
  end
end
