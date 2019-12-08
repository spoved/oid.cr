require "./game_object"

module Oid
  module Actor
    include GameObject
    include Oid::Helpers::Relationships(Oid::GameObject)

    abstract def name : String
  end
end
