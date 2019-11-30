require "logger"

module Oid
  module Service
    module Logger
      include Oid::Service

      abstract def level=(value : Logger::Severity)
      abstract def log(msg : String, level : Logger::Severity = Logger::INFO)
    end
  end
end
