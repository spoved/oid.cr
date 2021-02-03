require "../resources/**"

module Oid
  module Controller
    module View
      include Oid::Controller

      abstract def init_view(contexts : Contexts, entity)
      abstract def destroy_view
      abstract def bounding_box : Oid::Element::BoundingBox
    end
  end
end
