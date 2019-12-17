class RayLib::WindowController
  include Oid::Controller::Window

  def init_window(contexts, entity, config_service : Oid::Service::Config)
  end

  def resize_window(resolution)
  end

  def destroy_window
  end

  def register_listeners(entity : Entitas::IEntity)
  end
end
