module Oid
  module Controller
  end
end

require "./controllers/*"

macro register_controllers
  {% controllers = Oid::Controller.constants %}

  {% for controller in controllers %}
  {% controller_name = controller.stringify.downcase %}

  @[Context(Game)]
  class ::{{controller.id}} < Entitas::Component
    prop :instance, Oid::Controller::{{controller.id}}
  end
  {% end %}
end

register_controllers
