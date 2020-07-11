require "../src/oid"
require "../src/oid/raylib/*"
require "spoved"
require "entitas"

Spoved.logger.level = Logger::WARN

############
# Components
############
@[Component::Unique]
@[Context(Game)]
class BoardComponent < Entitas::Component
  prop :value, Oid::Vector2, Oid::Vector2.new(10, 10)
end

@[Component::Unique]
@[Context(Input)]
@[Entitas::Event(EventTarget::Any)]
@[Entitas::Event(EventTarget::Any, EventType::Removed)]
class BurstModeComponent < Entitas::Component
end

@[Context(Game)]
@[Entitas::Event(EventTarget::Self)]
class DestroyedComponent < Entitas::Component
end

@[Context(Game)]
class InteractiveComponent < Entitas::Component
end

@[Context(Game)]
class MovableComponent < Entitas::Component
end

############
# Services
############

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
    logger: RayLib::LoggerService.new,
    input: RayLib::InputService.new,
    config: ConfigService.new,
    time: RayLib::TimeService.new,
    view: RayLib::ViewService.new,
  )

  getter listeners : Set(Oid::EventListener) = Set(Oid::EventListener).new

  def create_systems(contexts : Contexts)
    Entitas::Feature.new("Systems")
      .add(ServiceRegistrationSystems.new(contexts, services))
      .add(Game::EventSystems.new(contexts))
      .add(Oid::Systems::EmitInput.new(contexts))
      .add(Oid::Systems::LoadAsset.new(contexts))
  end
end

controller = GameController.new

app = RayLib::Application.new("TEST")
app.start(
  controller: controller,
  init_hook: ->(cont : GameController) {
    context = cont.contexts.game
    context
      .create_entity
      .add_component_asset(
        name: "test.jpg",
        type: Oid::Enum::AssetType::Texture
      )

    # context.create_entity.add_position(Oid::Vector3.new(1.0, 1.0, 0.0))
  },
  draw_hook: ->(cont : GameController) {
    RayLib.draw_fps(10, 10)
    # cont.contexts.game.create_entity.add_position(Oid::Vector3.new(1.0, 1.0, 0.0))
  },
)
