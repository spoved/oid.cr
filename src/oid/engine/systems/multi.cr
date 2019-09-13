require "./../components/multi"

module IDistroyableEntity
  include Entitas::IEntity
  include Destroyed::Helper
end

module IViewableEntity
  include Entitas::IEntity
  include View::Helper
  include Oid::Actor
end

class SceneEntity < Entitas::Entity
  include IDistroyableEntity
  include IViewableEntity
end

class InputEntity < Entitas::Entity
  include IDistroyableEntity
  include IViewableEntity
end

class UiEntity < Entitas::Entity
  include IDistroyableEntity
  include IViewableEntity
end

require "./multi/*"

create_feature Multi, systems: [
  Oid::Systems::MultiAddView,
  Oid::Systems::MultiDestroy,
]
