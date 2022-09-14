# This system will add a `Oid::Components::SceneState` to the `SceneEntity` when a `Oid::Components::Scene` component is added.
class Oid::Systems::AddSceneState < ::Entitas::ReactiveSystem
  spoved_logger

  include Entitas::Systems::InitializeSystem
  include Oid::Components::SceneState::Listener

  protected property contexts : Contexts

  def initialize(@contexts); end

  def init
    @collector = get_trigger(contexts.scene)
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(SceneMatcher.scene.added)
  end

  def filter(entity : StageEntity)
    !entity.scene_state? && !entity.destroyed?
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |entity|
      entity = entity.as(SceneEntity)
      entity.add_component_scene_state
    end
  end
end
