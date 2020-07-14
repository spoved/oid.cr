class RayLib::WindowController
  include Oid::Controller::Window
  include Oid::Components::Destroyed::Listener

  getter contexts : ::Contexts

  def initialize(@contexts); end

  def window_entity : AppEntity
    contexts.app.window_entity
  end

  def init_window(contexts, entity, config_service : Oid::Service::Config)
    register_listeners(self.window_entity)

    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::WindowController - Initializing Window")
    RayLib.init_window(
      config_service.screen_w,
      config_service.screen_h,
      config_service.app_name,
    )
  end

  def should_close? : Bool
    RayLib.window_should_close
  end

  def resize_window(resolution)
  end

  def destroy_window
    RayLib.trace_log(RayLib::Enum::TraceLog::Info.value, "RayLib::WindowController - Closing Window")
    RayLib.close_window
  end

  def register_listeners(entity : Entitas::IEntity)
    entity.add_destroyed_listener(self)
  end

  def on_destroyed(entity, component : Oid::Components::Destroyed)
    self.destroy_window
  end
end
