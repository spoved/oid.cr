require "./transform"

module Oid
  class GameObject
    getter transform : Transform = Transform.new
    getter name : String

    def initialize(@name); end
  end
end
