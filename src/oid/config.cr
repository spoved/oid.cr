require "habitat"

module Oid
  class Config
    Habitat.create do
      setting resolution : NamedTuple(x: Int32, y: Int32) = {x: 800, y: 600}
      setting target_fps : Int32 = 60
      setting asset_dir : String = __DIR__
      setting enable_keyboard : Bool = false
      setting enable_mouse : Bool = false
      setting show_cursor : Bool = true
      setting fullscreen : Bool = false
    end
  end
end
