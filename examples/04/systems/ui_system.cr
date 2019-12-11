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

    # ////////////////////////////////////////////////////
    # TODO: Initialize your Ui here!
    # ////////////////////////////////////////////////////

    # text_box.actor.add_object(
    #   Oid::Text.new(
    #     text: "Hello World",
    #     font_size: 20,
    #     color: Oid::Color::DARKGRAY
    #   ),
    #   position: Oid::Vector3.new(-50.0, 0.0, 0.0),
    #   rotation: Oid::Vector3.zero,
    # )
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
