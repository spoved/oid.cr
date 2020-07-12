@[Context(Stage)]
@[Component::Unique]
class Board < Entitas::Component
end

@[Context(Stage)]
class Piece < Entitas::Component
  prop :grid_pos, Oid::Vector2
end

@[Context(Stage)]
class Blocker < Entitas::Component
end
