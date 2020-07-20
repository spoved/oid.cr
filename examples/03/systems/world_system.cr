class Example::WorldSystem
  spoved_logger

  include Example::Helper
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem

  protected property contexts : Contexts
  protected property actors : Entitas::Group(StageEntity)

  def initialize(@contexts)
    @actors = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.actor))
  end

  def init
    # Set camera position in 3d
    context.camera_entity.replace_position(Oid::Vector3.new(10.0, 10.0, 10.0))
    context.camera.type = Oid::Components::Camera::Type::Perspective
    context.camera_entity.rotate Oid::Vector3.up

    # Create a Grid
    context.create_entity
      .add_camera_target
      .add_position(Oid::Vector3.zero)
      .add_position_type(Oid::Enum::Position::Static)
      .add_view_element(
        value: Oid::Element::Grid.new(
          size: 10,
          spacing: 1.0
        )
      )

    # Create cube
    cube = context.create_entity
      .add_actor(name: "cube")
      .add_position(Oid::Vector3.new(0.0, 1.0, 0.0))
      .add_position_type(Oid::Enum::Position::Static)
      .add_view_element(
        value: Oid::Element::Cube.new(
          size: Oid::Vector3.new(2.0, 2.0, 2.0),
          color: Oid::Color::GRAY,
        )
      )
      .add_scale(1.0)
      .add_interactive

    cube_wires = context.create_entity
      .add_actor(name: "cube_wires")
      .add_position(Oid::Vector3.new(0.0, 0.0, 0.0))
      .add_view_element(
        value: Oid::Element::CubeWires.new(
          size: Oid::Vector3.new(2.0, 2.0, 2.0),
          color: Oid::Color::DARKGRAY,
        )
      )
    cube.add_child(cube_wires)

    cube_selected_wires = context.create_entity
      .add_actor(name: "cube_selected_wires")
      .add_position(Oid::Vector3.new(0.0, 0.0, 0.0))
      .add_view_element(
        value: Oid::Element::CubeWires.new(
          size: Oid::Vector3.new(2.2, 2.2, 2.2),
          color: Oid::Color::GREEN,
        )
      )
      .add_hidden
    cube.add_child(cube_selected_wires)
  end

  def execute
    # context.camera_entity.rotate Oid::Vector3.new(1, 1, 1)

    cube = context.get_entity_with_actor_name("cube")
    wires = context.get_entity_with_actor_name("cube_selected_wires")

    unless cube.nil?
      element = cube.view_element.value.as(Oid::Element::Cube)
      if element.color == Oid::Color::GRAY && cube.selected?
        cube.replace_view_element(
          value: Oid::Element::Cube.new(
            size: Oid::Vector3.new(2.0, 2.0, 2.0),
            color: Oid::Color::RED,
          )
        )

        if !wires.nil? && wires.hidden?
          wires.hidden = false
        end
      elsif element.color == Oid::Color::RED && !cube.selected?
        cube.replace_view_element(
          value: Oid::Element::Cube.new(
            size: Oid::Vector3.new(2.0, 2.0, 2.0),
            color: Oid::Color::GRAY,
          )
        )

        if !wires.nil? && !wires.hidden?
          wires.hidden = true
        end
      end
    end
  end
end
