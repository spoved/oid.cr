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

module Oid
  module Controller
    module Helper
      abstract def contexts : Contexts

      def window_controller
        self.contexts.app.window.value
      end

      def app_controller
        self.contexts.app.window.value
      end
    end
  end
end
