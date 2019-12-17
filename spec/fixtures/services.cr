class SpecCameraSystem
  include Oid::Service::Camera
end

class SpecConfigSystem
  include Oid::Service::Config

  def screen_w : Int32
    800
  end

  def screen_h : Int32
    600
  end

  def target_fps : Int32
    120
  end

  def show_fps? : Bool
    false
  end

  def enable_mouse? : Bool
    true
  end

  def enable_keyboard? : Bool
    true
  end
end

class SpecTimeSystem
  include Oid::Service::Time

  def target_fps=(value : Int32?)
  end

  def fps : Int32
    120
  end

  def frame_time : Float64
    1.0
  end

  def time : Float64
    1.0
  end

  def delta_time : Float64
    1.0
  end
end

class SpecViewSystem
  include Oid::Service::View

  def load_asset(contexts : Contexts, entity : Entitas::IEntity, asset_type : Oid::Enum::AssetType, asset_name : String)
    entity.add_view(SpecViewController.new(contexts, entity))
  end
end

class SpecLoggerSystem
  include Oid::Service::Logger
  property log_msg : String? = nil

  def clear
    self.log_msg = nil
  end

  def log(msg : String)
    self.log_msg = msg
  end

  def level=(value : Logger::Severity)
  end
end

class SpecInputSystem
  include Oid::Service::Input

  def key_pressed?(key : Oid::Enum::Key) : Bool
    true
  end

  # Detect if a key is being pressed
  def key_down?(key : Oid::Enum::Key) : Bool
    true
  end

  # Detect if a key has been released once
  def key_released?(key : Oid::Enum::Key) : Bool
    true
  end

  # Detect if a key is NOT being pressed
  def key_up?(key : Oid::Enum::Key) : Bool
    true
  end

  # Get latest key pressed
  def latest_key_pressed? : Oid::Enum::Key?
    Oid::Enum::Key::B
  end

  # # Input-related functions: mouse

  # Detect if a mouse button has been pressed once
  def mouse_button_pressed?(button) : Bool
    button == 0
  end

  # Detect if a mouse button is being pressed
  def mouse_button_down?(button) : Bool
    button == 1
  end

  # Detect if a mouse button has been released once
  def mouse_button_released?(button) : Bool
    button == 0
  end

  # Detect if a mouse button is NOT being pressed
  def mouse_button_up?(button) : Bool
    button == 0
  end

  # Returns mouse position X
  def mouse_x : Float64
    0.5
  end

  # Returns mouse position Y
  def mouse_y : Float64
    100.0
  end

  # Returns mouse position XY
  def mouse_position : Oid::Vector2
    Oid::Vector2.new mouse_x, mouse_y
  end

  # Returns mouse wheel move
  def mouse_wheel_move : Int32
    10
  end

  # # Input-related functions: touch

  # Returns touch position X for touch point 0 (relative to screen size)
  def touch_x : Float64
    300.0
  end

  # Returns touch position Y for touch point 0 (relative to screen size)
  def touch_y : Float64
    400.0
  end

  # Returns touch position XY for a touch point index (relative to screen size)
  def touch_position : Oid::Vector2
    Oid::Vector2.new touch_x, touch_y
  end
end
