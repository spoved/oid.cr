require "./components"

# The purpose of this system is to identify entities that have a `Sprite` Component
# but have not yet been given an associated `GameObject`.
# We therefore react on the addition of a `Sprite` Component and filter for
# !`View`Component. When the system is constructed, we will also create a
# parent `GameObject` to hold all of the child views.
# When we create a `GameObject` we set its parent then we use Entitas'
# `EntityLink` functionality to create a link between the `GameObject`
# and the entity that it belongs to. You'll see the effect of this linking
# if you open up your Unity hierarchy while running the game - the GameObject's
# inspector pane will show the entity it represents and all of its components
# right there in the inspector.
class AddViewSystem < Entitas::ReactiveSystem
  def get_trigger(context : Entitas::Context) : ICollector
    context.create_collector(GameMatcher.sprite)
  end

  def filter(entity)
    entity.has_sprite? && !entity.has_view?
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      go = Oid::GameObject.new("Game View")
      e.as(GameEntity).add_view(go)
    end
  end
end

# With the GameObjects in place, we can handle the sprites.
# This system reacts to the `Sprite` Component being added,
# just as the above one does, only this time we filter for
# only those entities that have already had a ViewComponent added.
# If the entity has a `View` Component we know it also has a
# GameObject which we can access and add or replace it's `SpriteRenderer`.
class RenderSpriteSystem < Entitas::ReactiveSystem
  def get_trigger(context : Entitas::Context) : ICollector
    context.create_collector(GameMatcher.sprite)
  end

  def filter(entity)
    entity.has_sprite? && entity.has_view?
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      # TODO: Load the sprite into GameObject
      puts e.as(GameEntity).sprite.name
    end
  end
end

class RenderPositionSystem < Entitas::ReactiveSystem
  def get_trigger(context : Entitas::Context) : ICollector
    context.create_collector(GameMatcher.position)
  end

  def filter(entity)
    entity.has_position? && entity.has_view?
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      e.as(GameEntity).view.game_objecy.transform.position = e.as(GameEntity).position.value
    end
  end
end

class RenderDirectionSystem < Entitas::ReactiveSystem
  def get_trigger(context : Entitas::Context) : ICollector
    context.create_collector(GameMatcher.direction)
  end

  def filter(entity)
    entity.has_direction? && entity.has_view?
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      e = e.as(GameEntity)
      ang = e.direction.value
      e.as(GameEntity).view.game_objecy.transform.rotation = RayLib::Quaternion.new(x: 0, y: 0, z: 0, w: ang - 90)
    end
  end
end
