module Oid
  @[Context(App)]
  @[Component::Unique]
  class Window < Entitas::Component
    prop :value, Oid::Controller::Window
  end
end
