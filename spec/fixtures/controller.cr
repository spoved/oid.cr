require "./services"

class SpecController < Entitas::Controller
  getter services : Oid::Services = Oid::Services.new(
    # application: ApplicationService.new,
    logger: SpecLoggerSystem.new,
    input: SpecInputSystem.new,
    config: SpecConfigSystem.new,
    time: SpecTimeSystem.new,
    view: SpecViewSystem.new,
    camera: SpecCameraSystem.new,
  )

  def create_systems(contexts : Contexts)
    Entitas::Feature.new("Systems")
      .add(Oid::ServiceRegistrationSystems.new(contexts, services))
      .add(Stage::EventSystems.new(contexts))
      .add(OidSystems.new(contexts))
  end
end

class SpecViewController
  include Oid::Controller::View
  include Oid::Position::Listener
  include Oid::Destroyed::Listener

  property destroy_view_was_called : Bool = false

  def initialize(contexts, entity, @active = false, @position = Oid::Vector3.zero, @scale = Oid::Vector3.zero)
    init_view(contexts, entity)
  end

  def init_view(contexts, entity)
    register_listeners(entity)
  end

  def destroy_view
    self.destroy_view_was_called = true
  end

  def register_listeners(entity : Entitas::IEntity)
    entity.add_position_listener(self)
    entity.add_destroyed_listener(self)
  end

  def on_position(entity, component : Oid::Position)
    self.position = component.value
  end

  def on_destroyed(entity, component : Oid::Destroyed)
    self.destroy_view
  end
end
