require "spec"
require "../src/oid"

class CustomActor
  include Oid::IActor

  getter transform : Oid::Transform
  getter name : String
end
