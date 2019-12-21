require "./systems/*"

create_feature Oid::Event, [
  App::EventSystems,
  Stage::EventSystems,
]

create_feature Oid, [
  Oid::EventSystems,

  # Application/Entity management
  Oid::Systems::WindowMangement,
  Oid::Systems::CameraManager,
  Oid::Systems::Application,
  Oid::Systems::MultiDestroy,

  # View systems
  Oid::Systems::AddPositionComponents,
  Oid::Systems::AddObjectBounds,
  Oid::Systems::AddView,
  Oid::Systems::HiddenManger,

  #
  Oid::Systems::Move,
  Oid::Systems::EmitInput,

]
