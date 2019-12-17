class RayLib::ApplicationSystem
  include Oid::Service::Application

  def init_controller(contexts : Contexts) : Oid::Controller::Application
    RayLib::ApplicationController.new(contexts)
  end
end
