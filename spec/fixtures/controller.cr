require "./services"

class SpecController < Entitas::Controller
  getter services : Oid::Services = Oid::Services.new(
    application: SpecApplicationService.new,
    logger: SpecLoggerService.new,
    input: SpecInputService.new,
    config: SpecConfigService.new,
    time: SpecTimeService.new,
    view: SpecViewService.new,
    camera: SpecCameraService.new,
    window: SpecWindowService.new,
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
  include Oid::Components::Destroyed::Listener
  private getter entity : Oid::RenderableEntity

  property destroy_view_was_called : Bool = false

  def initialize(contexts, @entity)
    init_view(contexts, @entity)
  end

  def init_view(contexts, entity)
    register_listeners(entity)
    entity.asset_loaded = true
  end

  def destroy_view
    self.destroy_view_was_called = true
  end

  def register_listeners(entity : Entitas::IEntity)
    entity.add_destroyed_listener(self)
  end

  def on_destroyed(entity, component : Oid::Components::Destroyed)
    self.destroy_view
  end

  def bounding_box : Oid::Element::BoundingBox
    if entity.view_element?
      Oid::CollisionFuncs.bounding_box_for_element(entity)
    elsif entity.has_asset?
      Oid::CollisionFuncs.bounding_box_for_asset(self.entity, 128, 128)
    else
      raise "Cannot calculate bounding box for #{entity.to_s}"
    end
  end
end

class SpecWindowController
  include Oid::Controller::Window
  include Oid::Components::Destroyed::Listener

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

  def on_destroyed(entity, component : Oid::Components::Destroyed)
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
