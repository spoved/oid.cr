require "./systems/*"

create_feature Oid::Event, [
  App::EventSystems,
  Stage::EventSystems,
]

create_feature Oid, [
  Oid::EventSystems,
  Oid::Systems::WindowMangement,
  Oid::Systems::Camera,
  Oid::Systems::EmitInput,
  Oid::Systems::AddPositionComponents,
  Oid::Systems::AddObjectBounds,
  Oid::Systems::AddView,
  Oid::Systems::Move,
  Oid::Systems::Application,
  Oid::Systems::MultiDestroy,
]
