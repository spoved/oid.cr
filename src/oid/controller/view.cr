require "../resources/**"

module Oid
  module Controller
    module View
      include Oid::Controller

      abstract def init_view(contexts, entity)
      abstract def destroy_view
    end
  end
end
