require "./services"

class SpecController < Entitas::Controller
  getter services : Oid::Services = Oid::Services.new(
    application: SpecApplicationSystem.new,
    logger: SpecLoggerSystem.new,
    input: SpecInputSystem.new,
    config: SpecConfigSystem.new,
    time: SpecTimeSystem.new,
    view: SpecViewSystem.new,
    camera: SpecCameraSystem.new,
    window: SpecWindowSystem.new,
  )

  def initialize(@contexts); end

  def create_systems(contexts : Contexts)
    Entitas::Feature.new("Systems")
      .add(Oid::ServiceRegistrationSystems.new(contexts, services))
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

class SpecWindowController
  include Oid::Controller::Window
  include Oid::Destroyed::Listener

  getter contexts : ::Contexts

  property window_destroyed = false

  def initialize(@contexts); end

  def window_entity : AppEntity
    contexts.app.window_entity
  end

  def init_window(contexts, entity, config_service : Oid::Service::Config)
    register_listeners(self.window_entity)
  end

  def resize_window(resolution)
  end

  def destroy_window
    self.window_destroyed = true
  end

  def register_listeners(entity : Entitas::IEntity)
    entity.add_destroyed_listener(self)
  end

  def on_destroyed(entity, component : Oid::Destroyed)
    self.destroy_window
  end

  def should_close? : Bool
    self.window_destroyed
  end
end

class SpecApplicationController
  include Oid::Controller::Application

  def initialize(@contexts); end

  def register_listeners(entity : Entitas::IEntity); end

  def init_application(contexts, entity, config_service : Oid::Service::Config); end

  def init(&block)
    yield
  end

  def update(&block)
    yield
  end

  def draw(&block)
    yield
  end

  def draw_ui(&block)
    yield
  end

  def cleanup(&block)
    yield
  end

  def exit(&block)
    yield
  end
end
