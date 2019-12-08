require "../../helpers/relationships"

module Oid
  module GameObject
    include JSON::Serializable
    property position : Oid::Vector3 = Oid::Vector3.zero
  end
end
