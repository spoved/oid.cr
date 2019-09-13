class CreateMoverSystem < Entitas::ReactiveSystem
  getter scene_context : SceneContext

  def initialize(contexts : Contexts)
    @scene_context = contexts.scene
    @collector = get_trigger(contexts.input)
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(InputMatcher.all_of(InputMatcher.right_mouse, InputMatcher.mouse_pressed))
  end

  def filter(entity : InputEntity)
    entity.has_mouse_pressed?
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      e = e.as(InputEntity)

      mover = scene_context.create_entity
      mover.is_mover = true
      mover.add_position(
        value: e.mouse_pressed.position
      )

      mover.add_direction(
        value: Random.new.rand(0..360).to_f32
      )

      mover.add_assign_view
      mover.add_texture(name: "Bee.png")
    end
  end
end
