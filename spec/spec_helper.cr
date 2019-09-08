require "spec"
require "../src/oid"

class CustomActor
  include Oid::Actor

  getter transform : Oid::Transform
  getter name : String
end
