class Example::CollisionEmitSystem < Entitas::ReactiveSystem
  protected property contexts : Contexts
  protected property context : InputContext
  protected property game_actors : Entitas::Group(GameEntity)

  def initialize(@contexts)
    @context = @contexts.input
    @collector = get_trigger(@context)
    @game_actors = @contexts.game.get_group(GameMatcher.all_of(GameMatcher.actor, GameMatcher.interactive))
  end

  def filter(entity : InputEntity)
    entity.input?
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(InputMatcher.input)
  end

  def execute(entities : Array(Entitas::IEntity))
    view_service = contexts.meta.view_service.instance
    camera = contexts.game.camera.value

    entities.each do |entity|
      entity = entity.as(InputEntity)

      # TODO: Check collision
      ray = view_service.get_mouse_ray(entity.input.position, camera.as(Oid::Camera3D))

      # puts entity.input.position
      game_actors.each do |actor|
        collision = view_service.check_mouse_collision(ray, actor.actor.bounds_cube)
        if collision
          contexts.game.create_entity
            .add_collision(
              ray: ray,
              target: actor
            )
        end
      end

      entity.destroyed = true
    end
  end
end
