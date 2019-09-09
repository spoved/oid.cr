#########################
# Scene components
#########################

@[Component::Unique]
@[Context(Scene)]
class Stage < Entitas::Component
  include Oid::IStage
end

@[Context(Scene)]
class Actor < Entitas::Component
  include Oid::IActor

  prop :name, String
  prop :transform, Oid::Transform, not_nil: true, method: create_trans

  # :nodoc:
  def create_trans : Oid::Transform
    Oid::Transform.new
  end

  # TODO: Need a better way to abstract this
  def draw(entity)
    trans = entity.actor.transform
    position = trans.position.to_v2
    rotation = entity.direction.value

    RayLib.draw_texture_ex(
      entity.texture.value,
      position,
      rotation,
      0.1f32,
      RayLib::Color::WHITE
    )
  end
end

#########################
# View components
#########################

@[Context(Scene)]
class View < Entitas::Component
end

#########################
# Render components
#########################

@[Context(Scene)]
class Texture < Entitas::Component
  prop :name, String
  prop :path, String
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
