class InputSystem < Entitas::ReactiveSystem
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

  # Select entities with position and is an actor
  def filter(entity : InputEntity)
    (entity.keyboard? && (entity.key_down? || entity.key_pressed? || entity.key_released?)) || entity.mouse_wheel?
  end

  def execute(entities : Array(Entitas::IEntity))
    camera = contexts.game.camera.value.as(Oid::Camera2D)

    entities.each do |e|
      e = e.as(InputEntity)

      if e.mouse_wheel?
        # camera.zoom += e.mouse_wheel.move * 0.1
      elsif e.keyboard?
        case e.keyboard.key
        when Oid::Enum::Key::Right
        when Oid::Enum::Key::Left
        when Oid::Enum::Key::A
          camera.rotate_x(-1)
        when Oid::Enum::Key::S
          camera.rotate_x(1)
        when Oid::Enum::Key::R
          # camera.zoom = 1.0
          camera.rotation = Oid::Vector3.zero
        else
          puts e.keyboard.key.class
        end
      end
    end

    # Set rotation limits
    if camera.rotation.x > 40
      camera.rotation.x = 40.0
    elsif camera.rotation.x < -40
      camera.rotation.x = -40.0
    end

    # Set zoom limit
    if camera.zoom > 3
      camera.zoom = 3.0
    elsif camera.zoom < 0.1
      camera.zoom = 0.1
    end
  end

  # def execute
  #   camera = contexts.game.camera.value.as(Oid::Camera2D)
  #   input_system = contexts.meta.input_service.instance
  # end
  #
  # def cleanup
  # end
end
