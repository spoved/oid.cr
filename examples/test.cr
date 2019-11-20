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

class GameController < Entitas::Controller
  getter services = Services.new(
    logger: DebugLogService.new
  )

  def create_systems(contexts : Contexts)
    Entitas::Feature.new("Systems")
      .add(ServiceRegistrationSystems.new(contexts, services))
  end
end

controller = GameController.new
controller.start

controller.update
