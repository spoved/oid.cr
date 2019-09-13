require "./systems/*"

create_controller Game, [
  MultiSystems,
  InputSystems,
  MovementSystems,
  RenderSystems,
  ViewSystems,
  CreateMoverSystem,
  CommandMoveSystem,
]
