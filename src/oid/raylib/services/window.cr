class RayLib::WindowService
  include Oid::Service::Window

  def init_controller(contexts : Contexts) : Oid::Controller::Window
    RayLib::WindowController.new(contexts)
  end
end
