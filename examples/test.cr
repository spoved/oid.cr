require "../src/oid"
require "../src/oid/engine/systems/input/emit_input"
require "../src/oid/engine/systems/movement/move"

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

      mover.add_texture(name: "tut_01/Bee.png")
    end
  end
end

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

create_controller Game, [
  InputSystems,
  MovementSystems,
  RenderSystems,
  ViewSystems,
  CreateMoverSystem,
  CommandMoveSystem,
]

Oid::Config.configure do |settings|
  settings.asset_dir = __DIR__
  settings.enable_mouse = true
  settings.enable_keyboard = true
  settings.show_fps = true
end

Oid.new_window(title: "Test")

controller = GameController.new

# Start window fiber
spawn do
  controller.start

  Oid.window.start do
    controller.update
  end
end

# Yield to the window
while Oid.window.visable?
  Fiber.yield
end
