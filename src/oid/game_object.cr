require "./transform"

module Oid
  class GameObject
    getter transform : Oid::Transform
    getter name : String

    def self.new(name : String)
      instance = Oid::GameObject.allocate
      instance.initialize(name, Oid::Transform.new(instance))
      instance
    end

    private def initialize(@name, @transform)
    end
  end
end
