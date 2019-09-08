module RayLib
  def self.key_down?(key : RayLib::Enum::Key)
    RayLib.is_key_down(key.value)
  end

  def self.key_up?(key : RayLib::Enum::Key)
    RayLib.is_key_up(key.value)
  end

  def self.key_pressed?(key : RayLib::Enum::Key)
    RayLib.is_key_pressed(key.value)
  end

  def self.key_released?(key : RayLib::Enum::Key)
    RayLib.is_key_released(key.value)
  end

  # Check if any key is pressed
  # NOTE: We limit keys check to keys between 32 (KEY_SPACE) and 126
  def self.any_key_pressed? : Bool
    key = RayLib.get_key_pressed
    if key >= 32 && key <= 126
      true
    else
      false
    end
  end

  # Get latest key pressed
  def self.get_key_pressed?
    val = RayLib.get_key_pressed
    if val >= 0
      RayLib::Enum::Key.new(val)
    else
      nil
    end
  rescue
    nil
  end
end
