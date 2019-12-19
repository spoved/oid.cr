class RayLib::ConfigService
  include Oid::Service::Config

  getter config : NamedTuple(
    app_name: String,
    screen_w: Int32,
    screen_h: Int32,
    target_fps: Int32,
    show_fps: Bool,
    enable_mouse: Bool,
    enable_keyboard: Bool,
    asset_path: String,
    camera_mode: String,
  )

  def initialize(@config); end

  def app_name : String
    config[:app_name]
  end

  def screen_w : Int32
    config[:screen_w]
  end

  def screen_h : Int32
    config[:screen_h]
  end

  def target_fps : Int32
    config[:target_fps]
  end

  def show_fps? : Bool
    config[:show_fps]
  end

  def enable_mouse? : Bool
    config[:enable_mouse]
  end

  def enable_keyboard? : Bool
    config[:enable_keyboard]
  end

  def asset_path : String
    config[:asset_path]
  end

  def camera_3d? : Bool
    config[:camera_mode] == "3d" ? true : false
  end
end
