require "./systems/**"

create_feature Oid::Feature::Event, [
  App::EventSystems,
  Stage::EventSystems,
]

create_feature Oid::Feature::View, [
  Oid::Systems::AddObjectBounds,
  Oid::Systems::AddView,
  Oid::Systems::HiddenManger,
]

create_feature Oid::Feature::Movement, [
  Oid::Systems::Move,
]

create_feature Oid::Feature::Input, [
  Oid::Systems::EmitInput,
]

create_feature Oid::Feature::App, [
  Oid::Systems::WindowMangement,
  Oid::Systems::CameraManager,
  Oid::Systems::Application,
]

create_feature Oid::Base, [
  Oid::Feature::EventSystems,

  # Application management
  Oid::Feature::AppSystems,

  # Entity management
  Oid::Systems::AddPositionComponents,
  Oid::Systems::RelationshipManager,
  Oid::Systems::MultiDestroy,

  Oid::Feature::MovementSystems,
  Oid::Feature::InputSystems,
  Oid::Feature::ViewSystems,
]