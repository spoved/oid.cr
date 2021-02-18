module Example::Helper

  macro included
    include Oid::Systems::StageHelper
  end

  abstract def contexts

  def context
    contexts.stage
  end

  def create_player(position = Oid::Vector3.new(0.0, 0.0, 0.0), origin = Oid::Enum::OriginType::Center)
    context.create_entity
      .add_actor(name: "player")
      .add_camera_target
      .add_position(position)
      .add_position_type(Oid::Enum::Position::Static)
      .add_view_element(
        value: Oid::Element::Rectangle.new(
          width: 20.0,
          height: 20.0,
          color: Oid::Color::BLUE
        ),
        origin: origin
      )
      .add_scale(1.0)
  end

  def random_move(entity)
    unless entity.move?
      entity.add_move(target: Oid::Vector3.new(
        x: Random.rand(-400.0...400.0),
        y: Random.rand(-300.0...300.0),
        z: entity.position.value.z,
      ))
    end
  end

  def scale_auto(entity)
    zoom_out = if entity.scale.value <= 0.0
                 true
               elsif entity.scale.value >= 1.0
                 false
               end

    if zoom_out
      entity.replace_scale(entity.scale.value + 0.01)
    else
      entity.replace_scale(entity.scale.value - 0.01)
    end
  end
end
