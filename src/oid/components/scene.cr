module Oid::Components
  @[Context(Scene)]
  class Scene
    prop :name, String, not_nil: true, index: true
    prop :default, Bool, not_nil: true, default: false
  end

  @[Context(Scene)]
  @[Entitas::Event(EventTarget::Self)]
  class SceneState < Entitas::Component
    prop :value, Oid::Enum::LoadState, default: Oid::Enum::LoadState::Unloaded
  end
end
