require "spec"
require "../src/oid"

alias Mat3 = Oid::Matrix::Mat3
alias Mat4 = Oid::Matrix::Mat4
alias Vec2 = Oid::Vector2
alias Vec3 = Oid::Vector3
alias Vec4 = Oid::Vector4
alias Q = Oid::Quaternion

# convenience function for creating Vec2
def vec2(x : Float64 = 0.0, y : Float64 = 0.0)
  Oid::Vector2.new(x, y)
end

# convenience function for creating Vec3
def vec3(x : Float64 = 0.0, y : Float64 = 0.0, z : Float64 = 0.0)
  Oid::Vector3.new(x, y, z)
end

# convenience function for creating Vec4
def vec4(x : Float64 = 0.0, y : Float64 = 0.0, z : Float64 = 0.0, w : Float64 = 0.0)
  Oid::Vector4.new(x, y, z, w)
end

# convenience function for creating Mat3
def mat3(x0 : Float64, x1 : Float64, x2 : Float64,
         y0 : Float64, y1 : Float64, y2 : Float64,
         z0 : Float64, z1 : Float64, z2 : Float64)
  Mat3.new(x0, x1, x2, y0, y1, y2, z0, z1, z2)
end

# convenience function for creating Mat3
def mat4(x0 : Float64, x1 : Float64, x2 : Float64, x3 : Float64,
         y0 : Float64, y1 : Float64, y2 : Float64, y3 : Float64,
         z0 : Float64, z1 : Float64, z2 : Float64, z3 : Float64,
         w0 : Float64, w1 : Float64, w2 : Float64, w3 : Float64)
  Mat4.new(x0, x1, x2, x3, y0, y1, y2, y3, z0, z1, z2, z3, w0, w1, w2, w3)
end

class SpecCameraService
  include Oid::Service::Camera
end

class SpecConfigService
  include Oid::Service::Config
end

class SpecTimeService
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

class SpecViewService
  include Oid::Service::View

  def load_asset(contexts : Contexts, entity : Entity::IEntity, asset_type : Oid::Enum::AssetType, asset_name : String)
    entity.add_view
  end
end

class SpecLoggerService
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

class SpecInputService
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
