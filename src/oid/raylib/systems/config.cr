class RayLib::ConfigSystem
  include Oid::Service::Config

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

  def asset_path : String
    settings.asset_path
  end
end
