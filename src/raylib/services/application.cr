class RayLib::ApplicationService
  include Oid::Service::Application

  def initialize
    # @init_hook = ->(contexts : Contexts) {}
    @draw_hook = ->draw(Contexts, Entitas::Group(StageEntity))
    @draw_ui_hook = ->draw(Contexts, Entitas::Group(StageEntity))
  end

  def init_controller(contexts : Contexts) : Oid::Controller::Application
    RayLib::ApplicationController.new(contexts)
  end

  def draw(contexts : Contexts, render_group : Entitas::Group(StageEntity))
    render_group.sort { |a, b| a.transform.z <=> b.transform.z }.each do |e|
      if (e.asset? && e.asset_loaded?) || e.view_element?
        e.view.value.draw
      end
    end
  end

  def render_fps
    RayLib.draw_fps(10, 10)
  end
end
