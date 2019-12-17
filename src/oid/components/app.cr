module Oid
  @[Context(App)]
  @[Component::Unique]
  class Application < Entitas::Component
    prop :value, Oid::Controller::Application
  end

  @[Context(App)]
  @[Component::Unique]
  class Window < Entitas::Component
    prop :value, Oid::Controller::Window
  end
end
