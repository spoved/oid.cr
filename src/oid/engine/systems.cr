require "./systems/*"

create_feature Oid, [
  Oid::Systems::MultiDestroy,
  Oid::Systems::ActorPosition,
  Oid::Systems::LoadAsset,
  Oid::Systems::EmitInput,
  Oid::Systems::Move,
]
