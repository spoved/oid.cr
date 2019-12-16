class BoxSystem
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem

  protected property contexts : Contexts
  protected property context : GameContext
  protected setter box_one : GameEntity? = nil
  protected setter box_two : GameEntity? = nil

  include_services Config, Input

  def box_one : GameEntity
    raise "Box One GameEntity is not set" if @box_one.nil?
    @box_one.as(GameEntity)
  end

  def box_two : GameEntity
    raise "Box Two GameEntity is not set" if @box_two.nil?
    @box_two.as(GameEntity)
  end

  def initialize(@contexts)
    @context = @contexts.game
  end

  def init
    _init_services

    self.box_one = context
      .create_entity
      .add_actor(name: "box_01")
      .add_position(
        Oid::Vector3.new(
          10.0,
          config_service.screen_h/2 - 50,
          0.0
        )
      )
      .add_view
    self.box_one.actor.add_object(
      Oid::Rectangle.new(
        width: 200.0,
        height: 100.0,
        color: Oid::Color::GOLD
      ),
    )

    self.box_two = context
      .create_entity
      .add_actor(name: "box_02")
      .add_position(
        Oid::Vector3.new(
          config_service.screen_w/2 - 30,
          config_service.screen_h/2 - 30,
          0.0
        )
      )
      .add_view
    self.box_two.actor.add_object(
      Oid::Rectangle.new(
        width: 60.0,
        height: 60.0,
        color: Oid::Color::BLUE
      ),
    )
  end

  def execute
    # if game state is paused
    if context.state.pause
      self.box_one.del_move if self.box_one.move?

      # if game state is not paused
    else
      position = input_service.mouse_position

      self.box_two.replace_position(
        Oid::Vector3.new(
          x: position.x - 30,
          y: position.y - 30,
          z: 0.0
        )
      )

      # Unless the box is already moving
      unless self.box_one.move?
        x = self.box_one.position.value.x < 10 ? (config_service.screen_w - 200.0) : 0.0
        self.box_one.add_move(
          target: Oid::Vector3.new(
            x: x,
            y: self.box_one.position.value.y,
            z: 0.0
          ),
          speed: context.state.box_a_speed
        )
      end
    end
  end
end
