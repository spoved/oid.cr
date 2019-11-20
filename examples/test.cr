require "../src/oid"
require "spoved"
require "entitas"

class DebugLogService
  include Oid::Service::Logger
  spoved_logger

  def log(msg : String)
    logger.info(msg)
  end
end

services = Services.new(
  logger: DebugLogService.new
)
