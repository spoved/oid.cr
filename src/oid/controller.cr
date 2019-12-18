module Oid
  module Controller
    def to_json(json : JSON::Builder)
      json.object do
        json.field("name", self.class.to_s)
        json.field("type", "Controller")
      end
    end
  end
end

require "./controller/*"
