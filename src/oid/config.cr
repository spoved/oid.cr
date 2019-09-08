require "habitat"

module Oid
  class Config
    Habitat.create do
      setting asset_dir : String = __DIR__

      setting resolution : NamedTuple(x: Int32, y: Int32) = {x: 800, y: 600}
      setting fullscreen : Bool = false

      setting target_fps : Int32 = 120
      setting show_fps : Bool = false

      setting enable_keyboard : Bool = false
      setting enable_mouse : Bool = false
      setting show_cursor : Bool = true
    end
  end
end
