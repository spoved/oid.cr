module Oid
  module Controller
    module View
      include Oid::Controller

      property position : Oid::Vector
      property scale : Oid::Vector
      property active : Bool

      abstract def init_view(contexts, entity)
      abstract def destroy_view
    end
  end
end
