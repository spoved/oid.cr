class Example::UiSystem
  include Entitas::Systems::InitializeSystem
  include Entitas::Systems::ExecuteSystem

  protected property contexts : Contexts
  protected property context : UiContext
  protected property actors : Entitas::Group(UiEntity)

  def initialize(@contexts)
    @context = @contexts.ui
    @actors = @contexts.ui.get_group(UiMatcher.all_of(UiMatcher.actor))
  end

  def init
    config_service = contexts.meta.config_service.instance
    view_service = contexts.meta.view_service.instance

    # ////////////////////////////////////////////////////
    # TODO: Initialize your Ui here!
    # ////////////////////////////////////////////////////

    text_box = context
      .create_entity
      .add_actor(name: "text_box_01")
      .add_position(
        Oid::Vector3.new(
          config_service.screen_w/2,
          10.0,
          0.0
        )
      )
      .add_view

    text_box.actor.add_object(
      Oid::Text.new(
        text: "Try selecting the box with mouse!",
        font_size: 20,
        color: Oid::Color::DARKGRAY
      ),
      position: Oid::Vector3.new(
        x: -160,
        y: 0.0,
        z: 0.0
      ),
      rotation: Oid::Vector3.zero,
    )

    selected_text = context
      .create_entity
      .add_actor(name: "text_box_02")
      .add_position(
        Oid::Vector3.new(
          config_service.screen_w/2,
          80.0,
          0.0
        )
      )

    selected_text.actor.add_object(
      Oid::Text.new(
        text: "BOX SELECTED",
        font_size: 30,
        color: Oid::Color::GREEN
      ),
      position: Oid::Vector3.new(
        x: -110,
        y: 0.0,
        z: 0.0
      ),
      rotation: Oid::Vector3.zero,
    )
  end

  def execute
    actors.each do |entity|
      entity = entity.as(UiEntity)

      # ////////////////////////////////////////////////////
      # TODO: Add game logic!
      # ////////////////////////////////////////////////////
    end
  end
end
