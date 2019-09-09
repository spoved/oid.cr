require "./systems/*"

create_controller Game, [
  InputSystems,
  MovementSystems,
  RenderSystems,
  ViewSystems,
  CreateMoverSystem,
  CommandMoveSystem,
]
