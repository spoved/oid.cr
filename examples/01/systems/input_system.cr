class Oid::Systems::InputSystem < Entitas::ReactiveSystem
  spoved_logger

  protected property contexts : Contexts
  protected property context : InputContext

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

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      e = e.as(InputEntity)

      if e.left_mouse? && e.mouse_pressed?
        context.create_entity
          .add_input(e.mouse_down.position)
      elsif e.mouse_wheel?
        # ////////////////////////////////////////////////////
        # TODO: Add logic for when mouse wheel is scrolled
        # ////////////////////////////////////////////////////
      elsif e.keyboard?
        case e.keyboard.key
        else
          puts "Input received from #{e.keyboard.key} !!!"
        end
      end
    end
  end
end
