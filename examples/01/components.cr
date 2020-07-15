@[Context(Stage)]
@[Component::Unique]
class Board < Entitas::Component
  prop :width, Int32
  prop :height, Int32
  prop :square_size, Float64

  def each_pos
    width.times do |x|
      height.times do |y|
        yield x, y
      end
    end
  end
end

@[Context(Stage)]
class Piece < Entitas::Component
  prop :grid_pos, Oid::Vector2
end

@[Context(Stage)]
class Blocker < Entitas::Component
end
