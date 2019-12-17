module Oid
  module Service
    module Window
      include Oid::Service

      abstract def init_window(contexts : Contexts, entity : Entity::IEntity)
    end
  end
end
