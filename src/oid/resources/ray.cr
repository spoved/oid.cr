module Oid
  struct Ray
    include JSON::Serializable

    property position : Oid::Vector3
    property direction : Oid::Vector3

    def initialize(@position, @direction); end
  end
end
