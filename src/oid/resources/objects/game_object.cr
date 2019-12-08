require "../../helpers/relationships"

module Oid
  module GameObject
    include Oid::Helpers::Relationships(Oid::GameObject)

    property position : Oid::Vector3 = Oid::Vector3.zero
  end
end
