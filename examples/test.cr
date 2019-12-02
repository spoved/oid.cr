require "../src/oid"
require "../src/oid/raylib/*"
require "spoved"
require "entitas"

class ConfigService
  include Oid::Service::Config

  def enable_mouse? : Bool
    true
  end

  def enable_keyboard? : Bool
    false
  end
end

class ApplicationService
  include Oid::Service::Application
  property frame_count = 0
end

class GameController < Entitas::Controller
  getter services = Services.new(
    application: ApplicationService.new,
    logger: RayLib::LoggerSystem.new,
    input: RayLib::InputSystem.new,
    config: ConfigService.new,
    time: RayLib::TimeSystem.new,
    view: RayLib::ViewSystem.new,
  )

  def create_systems(contexts : Contexts)
    Entitas::Feature.new("Systems")
      .add(ServiceRegistrationSystems.new(contexts, services))
      .add(Oid::Systems::EmitInput.new(contexts))
      .add(Oid::Systems::LoadAsset.new(contexts))
  end
end

controller = GameController.new

app = RayLib::Application.new("TEST")
app.start(controller,
  init_hook: ->(cont : Entitas::Controller) {
    context = cont.contexts.game
    context
      .create_entity
      .add_component_asset(
        name: "test.jpg",
        type: Oid::Enum::AssetType::Texture
      )
  }
)
