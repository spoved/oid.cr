class CollisionSystem
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem

  include Oid::Services::Helper

  protected property contexts : Contexts

  def initialize(@contexts); end

  def context : StageContext
    contexts.stage
  end

  def init
    context.create_entity
      .add_actor(name: "collision_box")
      .add_position(Oid::Vector3.zero)
      .add_view_element(
        value: Oid::Element::Rectangle.new(
          width: 0.0,
          height: 0.0,
          color: Oid::Color::GREEN
        ),
        origin: Oid::Enum::OriginType::Center
      )
  end

  def execute
    box1 = context.get_entities_with_name("box_01")
    box2 = context.get_entities_with_name("box_02")
    collision_box = context.get_entities_with_name("collision_box")

    return if box1.nil?
    return if box2.nil?
    return if collision_box.nil?

    # puts box1
    # rect = box2.actor.get_child(Oid::Rectangle).first

    # if view_service.collision_recs?(box1.actor, box2.actor)
    #   coll_rect = view_service.collision_rec(box1.actor, box2.actor)
    #   collision_box.add_view unless collision_box.view?
    #   rect = collision_box.actor.get_child(Oid::Rectangle).first

    #   collision_box.replace_position(Oid::Vector3.new(
    #     x: coll_rect[:x],
    #     y: coll_rect[:y],
    #     z: 0.0
    #   ))

    #   if rect.is_a?(Oid::Rectangle)
    #     rect.width = coll_rect[:width]
    #     rect.height = coll_rect[:height]
    #   end
    # else
    #   collision_box.del_view if collision_box.view?
    # end
  end
end
