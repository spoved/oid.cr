module Example::Systems
  abstract class WorldSystem
    macro inherited
      spoved_logger
    end

    include Oid::Services::Helper
    include Entitas::Systems::InitializeSystem
    include Entitas::Systems::ExecuteSystem
    include Example::Helper

    protected property contexts : Contexts
    protected property actors : Entitas::Group(StageEntity)
    protected property props : Entitas::Group(StageEntity)
    protected property zoom_out : Bool = false

    def initialize(@contexts)
      @actors = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.actor))
      @props = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.prop))
    end

    def context
      contexts.stage
    end

    abstract def init

    abstract def execute
  end

  abstract class InputSystem < Entitas::ReactiveSystem
    protected property contexts : Contexts
    protected property context : InputContext
    include Example::Helper

    def initialize(@contexts)
      @context = @contexts.input
      @collector = get_trigger(@context)
    end

    def get_trigger(context : Entitas::Context) : Entitas::ICollector
      context.create_collector(InputMatcher
        .any_of(
          InputMatcher.mouse_up,
          InputMatcher.mouse_down,
          InputMatcher.mouse_pressed,
          InputMatcher.mouse_released,
          InputMatcher.mouse_wheel,
          InputMatcher.key_up,
          InputMatcher.key_down,
          InputMatcher.key_pressed,
          InputMatcher.key_released
        ))
    end

    # Select entities with input components
    def filter(entity : InputEntity)
      (entity.keyboard? && (entity.key_down? || entity.key_pressed? || entity.key_released?)) ||
        (entity.mouse_wheel? || entity.mouse_up? || entity.mouse_down? || entity.mouse_pressed? || entity.mouse_released?)
    end

    abstract def execute(entities : Array(Entitas::IEntity))
  end
end
