require "./game_object"

module Oid
  module Actor
    include Oid::GameObject

    abstract def name : String
  end
end
