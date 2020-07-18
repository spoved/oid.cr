class Example::ScoreSystem < Entitas::ReactiveSystem
  spoved_logger
  include BoardLogic
  include Example::Helper
  include Entitas::Systems::InitializeSystem

  protected property contexts : Contexts
  protected property pieces : Entitas::Group(StageEntity)

  def initialize(@contexts)
    @collector = get_trigger(@contexts.stage)
    @pieces = @contexts.stage.get_group(StageMatcher.all_of(StageMatcher.piece))
  end

  def context
    contexts.stage
  end

  def get_trigger(context : Entitas::Context) : Entitas::ICollector
    context.create_collector(StageMatcher.all_of(StageMatcher.destroyed, StageMatcher.piece))
  end

  def filter(entity : StageEntity)
    entity.piece? && entity.destroyed?
  end

  def init
    board = contexts.stage.board_entity

    score = create_label("score", "Score 0",
      Oid::Vector3.new(0.0, 0.0, 600.0),
      Oid::Enum::OriginType::BottomCenter
    )
    score.add_score

    board.add_child(score)
  end

  def execute(entities : Array(Entitas::IEntity))
    score_entity = contexts.stage.score_entity
    score_entity.replace_score(score_entity.score.value + entities.size)

    label = score_entity.view_element
    score_entity.replace_view_element(
      value: Oid::Element::Text.new(
        text: "Score #{score_entity.score.value}",
        font_size: 20,
        color: Oid::Color::BLACK
      ),
      origin: label.origin
    )
  end
end
