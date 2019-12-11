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
      .add_actor(name: "text_box")
      .add_position(
        Oid::Vector3.new(
          config_service.screen_w/2,
          10.0,
          0.0
        )
      )
      .add_view

    text = Oid::Text.new(
      text: "Try selecting the box with mouse!",
      font_size: 20,
      color: Oid::Color::DARKGRAY
    )

    text_box.actor.add_object(
      text,
      position: Oid::Vector3.new(
        x: -160,
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
