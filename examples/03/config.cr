class RayLib::ConfigSystem
  add_settings(
    asset_path : String
  )
end

RayLib::ConfigSystem.configure do |settings|
  settings.screen_w = 800
  settings.screen_h = 450
  settings.target_fps = 120
  settings.show_fps = true
  settings.enable_mouse = true
  settings.enable_keyboard = true

  settings.asset_path = "examples/03/assets"
end

Oid::Systems::EmitInput.listen_for_keys(
  # ////////////////////////////////////////////////////
  # TODO: Define any keys you would like to listen for here!
  # ////////////////////////////////////////////////////

  Right,
  Left,
  Up,
  Down
)
