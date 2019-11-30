module Oid
  module Service
    module Config
      include Oid::Service

      abstract def enable_mouse? : Bool
      abstract def enable_keyboard? : Bool
    end
  end
end
