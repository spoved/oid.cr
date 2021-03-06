class Example::InputSystem < Entitas::ReactiveSystem
  spoved_logger

  protected property contexts : Contexts
  protected property context : InputContext
  protected property pieces : Entitas::Group(StageEntity)

  include Oid::Services::Helper
  include Example::Helper

  def initialize(@contexts)
    @context = @contexts.input
    @collector = get_trigger(@context)

    @pieces = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.piece).none_of(StageMatcher.blocker))
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(InputMatcher.any_of(
      InputMatcher.mouse_up,
      InputMatcher.mouse_down,
      InputMatcher.mouse_pressed,
      InputMatcher.mouse_released,
      InputMatcher.mouse_wheel,
      InputMatcher.key_up,
      InputMatcher.key_down,
      InputMatcher.key_pressed,
      InputMatcher.key_released
    ))
  end

  # Select entities with input components
  def filter(entity : InputEntity)
    (entity.keyboard? && (entity.key_down? || entity.key_pressed? || entity.key_released?)) ||
      (entity.mouse_wheel? || entity.mouse_up? || entity.mouse_down? || entity.mouse_pressed? || entity.mouse_released?)
  end

  def get_root_position
    contexts.stage.root_view_entity.position.value
  end

  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      e = e.as(InputEntity)

      if e.left_mouse? && e.mouse_pressed?
        # Get translated postion to root view
        position = e.mouse_pressed.position.to_v3 + get_root_position
        pieces.each do |piece|
          # If position is within box, delete the piece
          if piece.bbox.contains?(position)
            logger.trace { "Destroying #{piece.to_s}" }
            piece.destroyed = true
            break
          end
        end
      elsif e.keyboard?
        case e.keyboard.key
        when Oid::Enum::Key::B
          # TODO: Enable BURST
        else
          puts "Input received from #{e.keyboard.key} !!!"
        end
      end
    end
  end
end
