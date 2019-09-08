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
end
