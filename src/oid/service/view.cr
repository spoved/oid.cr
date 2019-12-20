module Oid
  module Service
    module View
      include Oid::Service

      abstract def init_controller(contexts : Contexts, entity : Oid::RenderableEntity) : Oid::Controller::View

      abstract def get_root_view(contexts : Contexts) : StageEntity
    end
  end
end
