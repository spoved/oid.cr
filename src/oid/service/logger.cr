require "log"

module Oid
  module Service
    module Logger
      include Oid::Service

      abstract def level=(value : ::Log::Severity)
      abstract def log(msg : String, level : ::Log::Severity = ::Log::Severity::Info)
    end
  end
end
