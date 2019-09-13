#########################
# Scene components
#########################

@[Component::Unique]
@[Context(Scene)]
class Stage < Entitas::Component
  include Oid::IStage
end

#########################
# Render components
#########################

@[Context(Scene)]
class Texture < Entitas::Component
  prop :name, String
  prop :path, String
  prop :scale, Float32, default: 1.0f32
  prop :value, RayLib::Texture2D
end

#########################
# Move components
#########################

@[Context(Scene)]
class Position < Entitas::Component
  prop :value, RayLib::Vector2
end

@[Context(Scene)]
class Direction < Entitas::Component
  prop :value, Float32
end

@[Context(Scene)]
class Mover < Entitas::Component
end

@[Context(Scene)]
class Move < Entitas::Component
  prop :target, RayLib::Vector2
  prop :speed, Float32, default: 1.0f32
end

@[Context(Scene)]
class MoveComplete < Entitas::Component
end
