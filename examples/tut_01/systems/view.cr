require "../components"

class AddViewSystem < Entitas::ReactiveSystem
  def self.new(contexts : Contexts)
    AddViewSystem.new(contexts.game)
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(GameMatcher.sprite)
  end

  def filter(entity : GameEntity)
    entity.has_sprite? && !entity.has_view?
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      go = Oid::GameObject.new("Game View")
      e.as(GameEntity).add_view(game_object: go)
    end
  end
end

class RenderSpriteSystem < Entitas::ReactiveSystem
  def self.new(contexts : Contexts)
    RenderSpriteSystem.new(contexts.game)
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(GameMatcher.sprite)
  end

  def filter(entity : GameEntity)
    entity.has_sprite? && entity.has_view?
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      e = e.as(GameEntity)
    end
  end
end

class RenderPositionSystem < Entitas::ReactiveSystem
  def self.new(contexts : Contexts)
    RenderPositionSystem.new(contexts.game)
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(GameMatcher.position)
  end

  def filter(entity : GameEntity)
    entity.has_position? && entity.has_view?
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      e = e.as(GameEntity)
      go = e.view.game_object.as(Oid::GameObject)
      go.transform.position = e.position.value.as(RayLib::Vector2)
    end
  end
end

class RenderDirectionSystem < Entitas::ReactiveSystem
  def self.new(contexts : Contexts)
    RenderDirectionSystem.new(contexts.game)
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(GameMatcher.direction)
  end

  def filter(entity)
    entity.as(GameEntity).has_direction? && entity.as(GameEntity).has_view?
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      e = e.as(GameEntity)
      if e.direction.value.nil?
        raise "No direction value for #{e}"
      end
      ang = e.direction.value.as(Float32)

      e.view.game_object.as(Oid::GameObject)
        .transform.rotation = RayLib::Quaternion.new(ang - 90, RayLib::Vector3.forward)
    end
  end
end

class ViewSystems < Entitas::Feature
  def initialize(contexts)
    @name = "View Systems"

    add AddViewSystem.new(contexts)
    add RenderPositionSystem.new(contexts)
    add RenderDirectionSystem.new(contexts)
    add RenderSpriteSystem.new(contexts)
  end
end
