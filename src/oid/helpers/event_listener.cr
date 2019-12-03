module Oid
  module EventListener
    abstract def register_listeners(entity : Entitas::IEntity)
  end
end
