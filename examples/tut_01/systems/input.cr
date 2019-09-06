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

  def execute
    position = RayLib.get_mouse_position

    # Left button

    if RayLib.is_mouse_button_down(0)
      left_mouse_entity.replace_mouse_down(position: position)
    end

    if RayLib.is_mouse_button_up(0)
      left_mouse_entity.replace_mouse_up(position: position)
    end

    if RayLib.is_mouse_button_pressed(0)
      left_mouse_entity.replace_mouse_pressed(position: position)
    end

    if RayLib.is_mouse_button_released(0)
      left_mouse_entity.replace_mouse_released(position: position)
    end

    # Right button

    if RayLib.is_mouse_button_down(1)
      right_mouse_entity.replace_mouse_down(position: position)
    end

    if RayLib.is_mouse_button_up(1)
      right_mouse_entity.replace_mouse_up(position: position)
    end

    if RayLib.is_mouse_button_pressed(1)
      right_mouse_entity.replace_mouse_pressed(position: position)
    end

    if RayLib.is_mouse_button_released(1)
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
    context.create_collector(InputMatcher.all_of(InputMatcher.right_mouse, InputMatcher.mouse_down))
  end

  def filter(entity : InputEntity)
    entity.has_mouse_down? && !entity.mouse_down.position.nil?
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      e = e.as(InputEntity)

      mover = game_context.create_entity
      mover.is_mover = true
      mover.add_position(
        value: e.mouse_down.position
      )

      mover.add_direction(
        value: Random.new.rand(0..360).to_f32
      )

      mover.add_sprite(name: "Bee")
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
    context.create_collector(InputMatcher.all_of(InputMatcher.right_mouse, InputMatcher.mouse_down))
  end

  def filter(entity : InputEntity)
    entity.has_mouse_down? && !entity.mouse_down.position.nil?
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
