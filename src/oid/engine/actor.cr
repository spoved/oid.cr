require "./modules/*"
require "./transform"

module Oid
  module IActor
    include Oid::Renderable

    abstract def name : String

    macro included
      private def initialize(@name, @transform)
      end

      def self.new(name : String)
        instance = {{@type.id}}.allocate
        instance.initialize(name, Oid::Transform.new(instance))
        instance
      end
    end
  end
end
