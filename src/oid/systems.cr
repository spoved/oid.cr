require "./systems/**"

create_feature Oid::Event, [
  App::EventSystems,
  Stage::EventSystems,
]

create_feature Oid, [
  Oid::EventSystems,
  Oid::Systems::AddPositionComponents,

  # Application/Entity management
  Oid::Systems::WindowMangement,
  Oid::Systems::CameraManager,
  Oid::Systems::Application,
  Oid::Systems::RelationshipManager,
  Oid::Systems::MultiDestroy,

  # View systems
  Oid::Systems::AddObjectBounds,
  Oid::Systems::AddView,
  Oid::Systems::HiddenManger,

  # Stage Systems
  Oid::Systems::Move,
  Oid::Systems::EmitInput,
]
