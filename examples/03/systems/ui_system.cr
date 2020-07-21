class Example::UISystem
  spoved_logger

  include Example::Helper
  include Oid::Services::Helper
  include Entitas::Systems::InitializeSystem
  # include Entitas::Systems::ExecuteSystem

  protected property contexts : Contexts

  def initialize(@contexts); end

  def init
    # Create UI
    label = create_label(
      "title",
      "Try selecting the box with mouse!",
      Oid::Vector3.new(400, 10, 0),
      Oid::Enum::OriginType::UpperCenter,
      position_type: Oid::Enum::Position::Static,
    )
    label.ui_element = true

    selected_label = create_label(
      "selected_label",
      "BOX SELECTED",
      Oid::Vector3.new(400, 40, 0),
      Oid::Enum::OriginType::UpperCenter,
      font_size: 30,
      color: Oid::Color::GREEN,
      position_type: Oid::Enum::Position::Static,
    )
    selected_label.hidden = true
    selected_label.ui_element = true
  end
end
