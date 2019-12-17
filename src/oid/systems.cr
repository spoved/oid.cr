require "./systems/*"

create_feature Oid::Event, [
  App::EventSystems,
  Stage::EventSystems,
]

create_feature Oid, [
  Oid::EventSystems,
  Oid::Systems::WindowMangement,
  Oid::Systems::EmitInput,
  Oid::Systems::LoadAsset,
  Oid::Systems::Move,
  Oid::Systems::CameraTrack,
  Oid::Systems::MultiDestroy,
  Oid::Systems::Application,
]
