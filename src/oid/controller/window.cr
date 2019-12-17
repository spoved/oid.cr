module Oid
  module Controller
    module Window
      include Oid::Controller

      abstract def init_window(contexts, entity, config_service : Oid::Service::Config)
      abstract def resize_window(resolution)
      abstract def destroy_window
      abstract def should_close? : Bool
    end
  end
end
