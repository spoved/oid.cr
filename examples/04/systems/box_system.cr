class BoxSystem
  include Oid::Services::Helper
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem

  protected property contexts : Contexts
  protected setter box_one : StageEntity? = nil
  protected setter box_two : StageEntity? = nil

  def box_one : StageEntity
    raise "Box One StageEntity is not set" if @box_one.nil?
    @box_one.as(StageEntity)
  end

  def box_two : StageEntity
    raise "Box Two StageEntity is not set" if @box_two.nil?
    @box_two.as(StageEntity)
  end

  def context
    contexts.stage
  end

  def initialize(@contexts); end

  def init
    root = context.create_entity
      .add_actor(name: "view_root")
      .add_position(
        Oid::Vector3.new(
          x: -(config_service.screen_w/2),
          y: -(config_service.screen_h/2),
          z: 0.0
        )
      )

    self.box_one = context.create_entity
      .add_actor(name: "box_01")
      .add_position(Oid::Vector3.new(x: 0.0, y: config_service.screen_h/2, z: 0.0))
      .add_view_element(
        value: Oid::Element::Rectangle.new(
          width: 200.0,
          height: 100.0,
          color: Oid::Color::GOLD
        ),
        origin: Oid::Enum::OriginType::Center
      )

    self.box_two = context.create_entity
      .add_actor(name: "box_02")
      .add_position(
        Oid::Vector3.new(
          config_service.screen_w/2 - 30,
          config_service.screen_h/2 - 30,
          0.0
        )
      )
      .add_view_element(
        value: Oid::Element::Rectangle.new(
          width: 60.0,
          height: 60.0,
          color: Oid::Color::BLUE
        ),
        origin: Oid::Enum::OriginType::Center
      )

    root.add_child(self.box_one)
    root.add_child(self.box_two)
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
      # unless self.box_one.move?
      #   x = self.box_one.position.value.x < 10 ? (config_service.screen_w - 200.0) : 0.0
      #   self.box_one.add_move(
      #     target: Oid::Vector3.new(
      #       x: x,
      #       y: self.box_one.position.value.y,
      #       z: 0.0
      #     ),
      #     speed: context.state.box_a_speed
      #   )
      # end
    end
  end
end
