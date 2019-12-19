class RayLib::ApplicationService
  include Oid::Service::Application

  def initialize
    @draw_hook = ->draw(Contexts, Entitas::Group(StageEntity))
  end

  def init_controller(contexts : Contexts) : Oid::Controller::Application
    RayLib::ApplicationController.new(contexts)
  end

  def draw(contexts : Contexts, render_group : Entitas::Group(StageEntity))
    render_group.sort { |a, b| a.position.value.z <=> b.position.value.z }.each do |e|
      if (e.asset? && e.asset_loaded?) || e.view_element?
        e.view.value.draw
      end
    end
  end
end