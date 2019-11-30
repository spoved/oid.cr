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
    RayLib.get_mouse_position
  end

  def touch_x : Float64
    RayLib.get_touch_x
  end

  def touch_y : Float64
    RayLib.get_touch_y
  end

  def touch_position : Oid::Vector2
    RayLib.get_touch_position
  end
end
