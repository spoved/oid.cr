module Oid
  module Service
    module Logger
      include Oid::Service

      abstract def log(msg : String)
    end
  end
end
