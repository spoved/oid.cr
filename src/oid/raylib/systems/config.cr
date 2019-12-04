class RayLib::ConfigSystem
  include Oid::Service::Config

  Habitat.create do
    setting screen_w : Int32
    setting screen_h : Int32
    setting target_fps : Int32
    setting show_fps : Bool
    setting enable_mouse : Bool
    setting enable_keyboard : Bool

    setting board_size : Oid::Vector2
    setting blocker_probability : Float64
  end

  def screen_w : Int32
    settings.screen_w
  end

  def screen_h : Int32
    settings.screen_h
  end

  def target_fps : Int32
    settings.target_fps
  end

  def show_fps : Bool
    settings.show_fps
  end

  def enable_mouse? : Bool
    settings.enable_mouse
  end

  def enable_keyboard? : Bool
    settings.enable_keyboard
  end
end
