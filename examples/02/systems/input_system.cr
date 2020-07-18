class Example::InputSystem < Entitas::ReactiveSystem
  protected property contexts : Contexts
  protected property context : InputContext
  protected property player_group : Entitas::Group(StageEntity)

  def initialize(@contexts)
    @context = @contexts.input
    @collector = get_trigger(@context)
    @player_group = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.actor, StageMatcher.player))
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
    camera = contexts.stage.camera_entity

    entities.each do |e|
      e = e.as(InputEntity)

      if e.mouse_wheel?
        camera.camera.zoom += e.mouse_wheel.move * 0.05
      elsif e.keyboard?
        case e.keyboard.key
        when Oid::Enum::Key::Right
          # Move player right by 2
          orig_pos = player_group.first.position.value
          player_group.first.replace_move(
            target: Oid::Vector3.new(
              x: orig_pos.x + 2,
              y: orig_pos.y,
              z: orig_pos.z
            )
          )
          camera.camera.offset.x = camera.camera.offset.x - 2
        when Oid::Enum::Key::Left
          # Move player left by 2
          orig_pos = player_group.first.position.value
          player_group.first.replace_move(
            target: Oid::Vector3.new(
              x: orig_pos.x - 2,
              y: orig_pos.y,
              z: orig_pos.z
            )
          )

          camera.camera.offset.x = camera.camera.offset.x + 2
        when Oid::Enum::Key::A
          camera.rotate_x(-1)
        when Oid::Enum::Key::S
          camera.rotate_x(1)
        when Oid::Enum::Key::R
          camera.camera.zoom = 1.0
          camera.replace_rotation(Oid::Vector3.zero)
        else
          puts e.keyboard.key.class
        end
      end
    end

    # Set rotation limits. between 320-360 and 0-40
    rot = camera.rotation.value
    if camera.rotation.value.x > 40.0
      rot.x = 40.0
      camera.replace_rotation(rot)
    elsif camera.rotation.value.x < -40.0
      # camera.rotation.value.x = -40.0
      rot.x = -40.0
      camera.replace_rotation(rot)
    end

    # Set zoom limit
    if camera.camera.zoom > 3
      camera.camera.zoom = 3.0
    elsif camera.camera.zoom < 0.1
      camera.camera.zoom = 0.1
    end
  end
end
