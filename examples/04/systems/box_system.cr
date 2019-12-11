class BoxSystem
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem

  protected property contexts : Contexts
  protected property context : GameContext
  protected setter box_one : GameEntity? = nil
  protected setter box_two : GameEntity? = nil
  protected setter config_service : Oid::Service::Config? = nil
  protected setter input_service : Oid::Service::Input? = nil

  def config_service : Oid::Service::Config
    raise "Config service is not set" if @config_service.nil?
    @config_service.as(Oid::Service::Config)
  end

  def input_service : Oid::Service::Input
    raise "Input service is not set" if @input_service.nil?
    @input_service.as(Oid::Service::Input)
  end

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
    @config_service = contexts.meta.config_service.instance
    @input_service = contexts.meta.input_service.instance

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
    # if game state is not paused
    unless context.state.pause
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
          speed: 4.0
        )
      end
    end
  end
end
