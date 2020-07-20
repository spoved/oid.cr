class Example::CollisionEmitSystem < Entitas::ReactiveSystem
  include Example::Helper
  include Oid::Services::Helper
  include Oid::CollisionFuncs

  protected property contexts : Contexts
  protected property context : InputContext
  protected property stage_actors : Entitas::Group(StageEntity)

  def initialize(@contexts)
    @context = @contexts.input
    @collector = get_trigger(@context)
    @stage_actors = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.actor, StageMatcher.interactive))
  end

  def filter(entity : InputEntity)
    entity.mouse_pressed? && entity.left_mouse?
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(InputMatcher.all_of(
      InputMatcher.left_mouse,
      InputMatcher.mouse_pressed,
    ))
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |entity|
      if entity.is_a?(InputEntity)
        ray = view_service.get_ray_from(
          entity.mouse_pressed.position,
          contexts.stage.camera_entity
        )

        stage_actors.each do |actor|
          next unless actor.interactive?

          bounding_box = bounding_box_for_element(actor)
          collision = collision_ray_box?(ray, bounding_box)

          if collision
            contexts.stage.create_entity
              .add_collision(
                ray: ray,
                target: actor
              )
          end
        end
      end
    end
  end
end
