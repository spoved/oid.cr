require "./transformable"

module Oid
  module Renderable
    include Transformable

    abstract def draw
  end
end
