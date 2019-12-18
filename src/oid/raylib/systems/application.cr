class RayLib::ApplicationSystem
  include Oid::Service::Application

  def initialize
    @draw_hook = ->draw(Oid::Controller::Application)
  end

  def init_controller(contexts : Contexts) : Oid::Controller::Application
    RayLib::ApplicationController.new(contexts)
  end

  def draw(app_controller : Oid::Controller::Application)
    app_controller.view_service.renderable_entities(app_controller.contexts).each do |e|
      app_controller.view_service.draw(e)
    end
  end
end
