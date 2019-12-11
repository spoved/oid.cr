class Example::CollisionSystem < Entitas::ReactiveSystem
  protected property contexts : Contexts
  protected property context : GameContext
  protected property game_actors : Entitas::Group(GameEntity)
  protected property ui_actors : Entitas::Group(UiEntity)

  def initialize(@contexts)
    @context = @contexts.game
    @collector = get_trigger(@context)
    @game_actors = @contexts.game.get_group(GameMatcher.all_of(GameMatcher.actor))
    @ui_actors = @contexts.ui.get_group(UiMatcher.all_of(UiMatcher.actor))
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(GameMatcher.collision)
  end

  def execute(entities : Array(Entitas::IEntity))
    view_service = contexts.meta.view_service.instance
    camera = contexts.game.camera.value

    entities.each do |entity|
      entity = entity.as(GameEntity)
      actor = entity.collision.target.as(GameEntity).actor

      # Change cube color
      cube = actor.get_child(Oid::Cube).first
      case cube.as(Oid::Cube).color
      when Oid::Color::GRAY
        cube.as(Oid::Cube).color = Oid::Color::RED
      when Oid::Color::RED
        cube.as(Oid::Cube).color = Oid::Color::GRAY
      end

      # Change wire color
      wire = actor.get_child(Oid::CubeWires).first.as(Oid::CubeWires)
      case wire.color
      when Oid::Color::MAROON
        wire.color = Oid::Color::DARKGRAY
      when Oid::Color::DARKGRAY
        wire.color = Oid::Color::MAROON
      end

      # Add view to selected text and wires
      game_actors.each do |e|
        if e.actor.name == "selected_wires"
          if e.view?
            e.del_view
          else
            e.add_view
          end
        end
      end

      ui_actors.each do |e|
        if e.actor.name == "text_box_02"
          if e.view?
            e.del_view
          else
            e.add_view
          end
        end
      end

      entity.destroyed = true
    end
  end
end
