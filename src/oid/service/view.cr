module Oid
  module Service
    module View
      include Oid::Service

      abstract def init_controller(contexts : Contexts, entity : Oid::RenderableEntity) : Oid::Controller::View
    end
  end
end
