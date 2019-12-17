require "./systems/*"

create_feature Oid, [
  Oid::Systems::EmitInput,
  Oid::Systems::LoadAsset,
  Oid::Systems::Move,
  Oid::Systems::CameraTrack,
  Oid::Systems::MultiDestroy,
]
