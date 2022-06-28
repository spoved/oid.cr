require "./entity_helper"

module Oid::Systems::UiHelper
  include Oid::Systems::EntityHelper

  abstract def contexts
  abstract def context

  def camera
    context.camera_entity
  end

  # Create a sprite button entity. If no parent is provided, it will be added as a child of the camera
  def sprite_button(name,
                    asset,
                    position = Oid::Vector3.new(2.5 - (68.0/2), 0.0, 10.0),
                    origin = Oid::Enum::OriginType::UpperLeft,
                    position_type = Oid::Enum::Position::Relative,
                    parent = nil)
    button = context.create_entity
      .add_ui_element
      .add_position(position)
      .add_position_type(position_type)
      .add_asset(**asset)
      .add_scale(1.0)

    camera.add_child(button) if parent.nil?
  end
end
