class RayLib::InputSystem
  include Oid::Service::Input

  def key_pressed?(key) : Bool
    RayLib.is_key_pressed(key)
  end

  def key_down?(key) : Bool
    RayLib.is_key_down(key)
  end

  def key_released?(key) : Bool
    RayLib.is_key_released(key)
  end

  def key_up?(key) : Bool
    RayLib.is_key_up(key)
  end

  def latest_key_pressed? : Oid::Enum::Key?
    key = RayLib.get_key_pressed?
    if key.nil?
      nil
    else
      Oid::Enum::Key.new(key.value)
    end
  end

  def mouse_button_pressed?(button) : Bool
    RayLib.is_mouse_button_pressed(button)
  end

  def mouse_button_down?(button) : Bool
    RayLib.is_mouse_button_down(button)
  end

  def mouse_button_up?(button) : Bool
    RayLib.is_mouse_button_up(button)
  end

  def mouse_button_released?(button) : Bool
    RayLib.is_mouse_button_released(button)
  end

  def mouse_x : Float64
    RayLib.get_mouse_x
  end

  def mouse_y : Float64
    RayLib.get_mouse_y
  end

  def mouse_position : Oid::Vector2
    pos = RayLib.get_mouse_position
    Oid::Vector2.new(x: pos.x, y: pos.y)
  end

  def touch_x : Float64
    RayLib.get_touch_x
  end

  def touch_y : Float64
    RayLib.get_touch_y
  end

  def touch_position : Oid::Vector2
    pos = RayLib.get_touch_position
    Oid::Vector2.new(x: pos.x, y: pos.y)
  end
end
