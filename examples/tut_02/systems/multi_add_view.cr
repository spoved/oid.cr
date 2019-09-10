require "../components"

module IViewableEntity
  include Entitas::IEntity
  include Destroyed::Helper
  include Oid::Actor
end

class SceneEntity < Entitas::Entity
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

  private property top_view_container : Oid::Transform = Oid::Transform.new
  private property view_containers : Hash(String, Oid::Transform) = Hash(String, Oid::Transform).new
  private property _contexts : Contexts

  def initialize(contexts : Contexts)
    @_contexts = contexts

    contexts.all_contexts.each do |ctx|
      if ctx.is_a?(SceneContext) || ctx.is_a?(InputContext) || ctx.is_a?(UiContext)
        ctx_name = ctx.info.name
        ctx_view_container = ctx.create_entity.as(IViewableEntity).transform
        ctx_view_container.parent = top_view_container
        view_containers[ctx_name] = ctx_view_container
      end
    end

    super
  end

  def get_trigger(contexts : ::Contexts) : Array(Entitas::ICollector)
    [
      contexts.scene.create_collector(SceneMatcher.assign_view),
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
      e.add_view
      e.is_assign_view = false
    end
  end
end
