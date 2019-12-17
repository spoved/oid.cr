module Oid
  module Controller
    module View
      include Oid::Controller

      property active : Bool
      property position : Oid::Vector
      property scale : Oid::Vector

      abstract def init_view(contexts, entity)
      abstract def destroy_view
    end
  end
end
