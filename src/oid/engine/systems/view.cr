require "./view/*"

create_feature View, systems: [
  Oid::Systems::ViewDirection,
  Oid::Systems::ViewPosition,
]
