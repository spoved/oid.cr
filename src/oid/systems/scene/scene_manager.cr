class Oid::Systems::SceneManager < ::Entitas::ReactiveSystem
  spoved_logger

  include Entitas::Systems::InitializeSystem

  protected property contexts : Contexts
  getter scenes : Entitas::Group(SceneEntity)

  def context
    contexts.scene
  end

  def initialize(@contexts)
    @scenes = context.get_group(SceneMatcher.all_of(SceneMatcher.scene, SceneMatcher.scene_state))
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(SceneMatcher.collidable.added)
  end

  def init
    scenes.on_entity_added &->on_entity_added(Entitas::Events::OnEntityAdded)
    scenes.on_entity_updated &->on_entity_updated(Entitas::Events::OnEntityUpdated)
  end

  def on_entity_added(event : Entitas::Events::OnEntityAdded)
    e = event.entity.as(SceneEntity)
    comp = event.component
    if comp.is_a?(Oid::Components::SceneState)
      logger.info &.emit "on_entity_added", scene: e.scene.name, state: comp.value.to_s
    end
  end

  def on_entity_updated(event : Entitas::Events::OnEntityUpdated)
    e = event.entity.as(SceneEntity)
    n_comp = event.new_component
    p_comp = event.prev_component

    if n_comp.is_a?(Oid::Components::SceneState) && p_comp.is_a?(Oid::Components::SceneState)
      logger.info &.emit "on_entity_updated", scene: e.scene.name, prev_state: p_comp.value.to_s, new_state: n_comp.value.to_s
    end
  end
end
