class RayLib::ConfigService
  include Oid::Service::Config

  add_settings(
    app_name : String,
    screen_w : Int32,
    screen_h : Int32,
    target_fps : Int32,
    show_fps : Bool,
    enable_mouse : Bool,
    enable_keyboard : Bool,
    camera_mode : String,
    asset_path : String,
  )

  def initialize(**args)
    {% for var in @type.instance_vars %}
    @{{var}} = args[:{{var}}]
    {% end %}
  end

  def app_name : String
    @app_name
  end

  def screen_w : Int32
    @screen_w
  end

  def screen_h : Int32
    @screen_h
  end

  def target_fps : Int32
    @target_fps
  end

  def show_fps? : Bool
    @show_fps
  end

  def enable_mouse? : Bool
    @enable_mouse
  end

  def enable_keyboard? : Bool
    @enable_keyboard
  end

  def asset_path : String
    @asset_path
  end

  def camera_3d? : Bool
    @camera_mode == "3d" ? true : false
  end
end
