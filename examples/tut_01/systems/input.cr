require "../components"

class EmitInputSystem
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem

  protected property context : InputContext
  protected setter left_mouse_entity : InputEntity? = nil
  protected setter right_mouse_entity : InputEntity? = nil

  def left_mouse_entity : InputEntity
    @left_mouse_entity ||= context.left_mouse_entity.as(InputEntity)
  end

  def right_mouse_entity : InputEntity
    @right_mouse_entity ||= context.right_mouse_entity.as(InputEntity)
  end

  def self.new(contexts : Contexts)
    EmitInputSystem.new(contexts.input)
  end

  def initialize(@context); end

  def init
    context.is_left_mouse = true
    self.left_mouse_entity = context.left_mouse_entity
    context.is_right_mouse = true
    self.right_mouse_entity = context.right_mouse_entity
  end

  def get_mouse(button)
    {
      down:     RayLib.is_mouse_button_down(button),
      up:       RayLib.is_mouse_button_up(button),
      pressed:  RayLib.is_mouse_button_pressed(button),
      released: RayLib.is_mouse_button_released(button),
    }
  end

  def execute
    position = RayLib.get_mouse_position

    left_mouse = get_mouse(0)
    right_mouse = get_mouse(1)

    # Left button

    if left_mouse[:down]
      left_mouse_entity.replace_mouse_down(position: position)
    end

    if left_mouse[:up]
      left_mouse_entity.replace_mouse_up(position: position)
    end

    if left_mouse[:pressed]
      left_mouse_entity.replace_mouse_pressed(position: position)
    end

    if left_mouse[:released]
      left_mouse_entity.replace_mouse_released(position: position)
    end

    # Right button

    if right_mouse[:down]
      right_mouse_entity.replace_mouse_down(position: position)
    end

    if right_mouse[:up]
      right_mouse_entity.replace_mouse_up(position: position)
    end

    if right_mouse[:pressed]
      right_mouse_entity.replace_mouse_pressed(position: position)
    end

    if right_mouse[:released]
      right_mouse_entity.replace_mouse_released(position: position)
    end
  end
end

class CreateMoverSystem < Entitas::ReactiveSystem
  getter game_context : GameContext

  def initialize(contexts : Contexts)
    @game_context = contexts.game
    @collector = get_trigger(contexts.input)
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(InputMatcher.all_of(InputMatcher.right_mouse, InputMatcher.mouse_pressed))
  end

  def filter(entity : InputEntity)
    entity.has_mouse_pressed? && !entity.mouse_pressed.position.nil?
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      e = e.as(InputEntity)

      mover = game_context.create_entity
      mover.is_mover = true
      mover.add_position(
        value: e.mouse_pressed.position
      )

      mover.add_direction(
        value: Random.new.rand(0..360).to_f32
      )

      mover.add_sprite(name: "Bee.png")
    end
  end
end

class CommandMoveSystem < Entitas::ReactiveSystem
  getter game_context : GameContext
  getter movers : Entitas::Group(GameEntity)

  def initialize(contexts : Contexts)
    @game_context = contexts.game
    @movers = @game_context.get_group(GameMatcher.all_of(GameMatcher.mover).none_of(GameMatcher.move))
    @collector = get_trigger(contexts.input)
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(InputMatcher.all_of(InputMatcher.left_mouse, InputMatcher.mouse_down))
  end

  def filter(entity : InputEntity)
    entity.has_mouse_pressed? && !entity.mouse_pressed.position.nil?
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      e = e.as(InputEntity)
      ms = movers.get_entities
      return if ms.size <= 0

      ms.sample.replace_move(
        target: e.mouse_down.position
      )
    end
  end
end

class InputSystems < Entitas::Feature
  def initialize(contexts)
    @name = "Input Systems"
    add EmitInputSystem.new(contexts)
    add CreateMoverSystem.new(contexts)
    add CommandMoveSystem.new(contexts)
  end
end
