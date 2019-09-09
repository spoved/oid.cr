class CommandMoveSystem < Entitas::ReactiveSystem
  getter scene_context : SceneContext
  getter movers : Entitas::Group(SceneEntity)

  def initialize(contexts : Contexts)
    @scene_context = contexts.scene
    @movers = @scene_context.get_group(SceneMatcher.all_of(SceneMatcher.mover).none_of(SceneMatcher.move))
    @collector = get_trigger(contexts.input)
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(InputMatcher.all_of(InputMatcher.left_mouse, InputMatcher.mouse_down))
  end

  def filter(entity : InputEntity)
    entity.has_mouse_pressed?
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      e = e.as(InputEntity)
      ms = movers.get_entities

      return if ms.empty?

      ms.sample.replace_move(
        target: e.mouse_down.position
      )
    end
  end
end
