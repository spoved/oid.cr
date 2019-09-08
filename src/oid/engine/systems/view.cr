require "./view/*"

create_feature View, systems: [
  Oid::Systems::AddView,
  Oid::Systems::ViewDirection,
  Oid::Systems::ViewPosition,
]
