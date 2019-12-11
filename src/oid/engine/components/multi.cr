@[Context(Game, Ui, Input)]
@[Entitas::Event(EventTarget::Self)]
class Destroyed < Entitas::Component
end

@[Context(Game, Ui, Input)]
@[Entitas::Event(EventTarget::Self)]
class Position < Entitas::Component
  prop :value, Oid::Vector3
end

@[Context(Game, Ui)]
class View < Entitas::Component
  prop :scale, Float64, default: 1.0
  prop :rotation, Float64, default: 1.0
end

@[Context(Game, Ui)]
class Actor < Entitas::Component
  include Oid::Actor
  prop :name, String
end

@[Context(Game, Ui)]
class Asset < Entitas::Component
  prop :name, String
  prop :type, Oid::Enum::AssetType
end

module RenderableEntity
  include Asset::Helper
  include Actor::Helper
  include View::Helper
  include Position::Helper
  include Destroyed::Helper
end

class UiEntity < Entitas::Entity
  include RenderableEntity
end

class GameEntity < Entitas::Entity
  include RenderableEntity
end
