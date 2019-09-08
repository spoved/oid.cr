require "./transform"

module Oid
  module Actor
    getter transform : Oid::Transform
    getter name : String

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
