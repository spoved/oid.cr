module Oid
  module Service
    module Window
      include Oid::Service

      abstract def init_controller(contexts : Contexts) : Oid::Controller::Window
    end
  end
end
