class CollisionSystem
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem
  include Example::Helper

  include Oid::Services::Helper

  protected property contexts : Contexts

  def initialize(@contexts); end

  def context : StageContext
    contexts.stage
  end

  def init
    col_box = context.create_entity
      .add_actor(name: "collision_box")
      .add_position(Oid::Vector3.zero)
      .add_position_type(Oid::Enum::Position::Static)

      .add_view_element(
        value: Oid::Element::Rectangle.new(
          width: 0.0,
          height: 0.0,
          color: Oid::Color::GREEN
        ),
        origin: Oid::Enum::OriginType::UpperLeft
      )
    # box2 = context.get_entity_with_actor_name("box_02")
    # box2.add_child col_box
    col_box.add_child generate_origin_grid("collision_box_origin", Oid::Color::RED, 60.0)
  end

  def execute
    box1 = context.get_entity_with_actor_name("box_01")
    box2 = context.get_entity_with_actor_name("box_02")
    collision_box = context.get_entity_with_actor_name("collision_box")

    return if box1.nil? || !box1.collidable?
    return if box2.nil? || !box1.collidable?
    return if collision_box.nil?

    # rect = box2.view_element.value.as(Oid::Element::Rectangle)

    if Oid::CollisionFuncs.collision_recs?(box1, box2)
      coll_rect = Oid::CollisionFuncs.collision_rec(box1, box2)
      collision_box.replace_position(Oid::Vector3.new(coll_rect[:x], coll_rect[:y], 1000))

      collision_box.replace_view_element(
        value: Oid::Element::Rectangle.new(
          width: coll_rect[:width],
          height: coll_rect[:height],
          color: Oid::Color::GREEN
        ),
        origin: Oid::Enum::OriginType::UpperLeft
      )
    else
      collision_box.del_view_element if collision_box.view_element?
    end
  end
end
