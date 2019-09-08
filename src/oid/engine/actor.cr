require "./transform"

module Oid
  module IActor
    abstract def name : String
    abstract def transform : Oid::Transform

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
