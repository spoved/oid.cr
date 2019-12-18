class RayLib::ConfigService
  add_settings(
    asset_path : String
  )
end

RayLib::ConfigService.configure do |settings|
  settings.screen_w = 800
  settings.screen_h = 450
  settings.target_fps = 120
  settings.show_fps = true
  settings.enable_mouse = true
  settings.enable_keyboard = false

  settings.asset_path = ""
end

# Oid::Systems::EmitInput.listen_for_keys

# ////////////////////////////////////////////////////
# TODO: Define any keys you would like to listen for here!
# ////////////////////////////////////////////////////
