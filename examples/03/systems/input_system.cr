class Example::InputSystem < Entitas::ReactiveSystem
  protected property contexts : Contexts
  protected property context : InputContext

  def initialize(@contexts)
    @context = @contexts.input
    @collector = get_trigger(@context)
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(InputMatcher
      .any_of(
        InputMatcher.mouse_wheel,
        InputMatcher.key_up,
        InputMatcher.key_down,
        InputMatcher.key_pressed,
        InputMatcher.key_released
      ))
  end

  # Select entities with input components
  def filter(entity : InputEntity)
    (entity.keyboard? && (entity.key_down? || entity.key_pressed? || entity.key_released?)) || entity.mouse_wheel?
  end

  def execute(entities : Array(Entitas::IEntity))
    camera = contexts.game.camera.value.as(Oid::Camera3D)

    entities.each do |e|
      e = e.as(InputEntity)

      if e.mouse_wheel?
        # ////////////////////////////////////////////////////
        # TODO: Add logic for when mouse wheel is scrolled
        # ////////////////////////////////////////////////////
      elsif e.keyboard?
        case e.keyboard.key
        when Oid::Enum::Key::Right
          # ////////////////////////////////////////////////////
          # TODO: Add logic for when right key is pressed
          # ////////////////////////////////////////////////////
        when Oid::Enum::Key::Left
          # ////////////////////////////////////////////////////
          # TODO: Add logic for when left key is pressed
          # ////////////////////////////////////////////////////
        else
          puts "Input received from #{e.keyboard.key} !!!"
        end
      end
    end
  end
end