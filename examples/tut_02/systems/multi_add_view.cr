require "../components"

module IViewableEntity
  include Entitas::IEntity
  include Destroyed::Helper
end

class GameEntity < Entitas::Entity
  include IViewableEntity
end

class InputEntity < Entitas::Entity
  include IViewableEntity
end

class UiEntity < Entitas::Entity
  include IViewableEntity
end

class MultiAddViewSystem < Entitas::MultiReactiveSystem
  spoved_logger

  private property top_view_container : Oid::Transform = Oid::Actor.new("Views").transform
  private property view_containers : Hash(String, Oid::Transform) = Hash(String, Oid::Transform).new
  private property _contexts : Contexts

  def initialize(contexts : Contexts)
    @_contexts = contexts

    contexts.all_contexts.each do |ctx|
      ctx_name = ctx.info.name
      ctx_view_container = Oid::Actor.new("#{ctx_name} Views").transform
      ctx_view_container.set_parent(top_view_container)
      view_containers[ctx_name] = ctx_view_container
    end

    super
  end

  def get_trigger(contexts : ::Contexts) : Array(Entitas::ICollector)
    [
      contexts.game.create_collector(GameMatcher.assign_view),
      contexts.input.create_collector(InputMatcher.assign_view),
      contexts.ui.create_collector(InputMatcher.assign_view),
    ] of Entitas::ICollector
  end

  def filter(entity : IViewableEntity)
    entity.has_assign_view? && !entity.has_view?
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      e = e.as(IViewableEntity)
      ctx_name = e.context_info.name
      actor = Oid::Actor.new("#{ctx_name} View")
      e.add_view(actor: actor)
      # go.link(e, _contexts.get_context_by_name(ctx_name))
      e.is_assign_view = false
    end
  end
end
