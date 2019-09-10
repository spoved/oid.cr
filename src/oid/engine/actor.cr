require "./modules/*"
require "./transform"

module Oid
  module Actor
    include Oid::Renderable

    @transform : Oid::Transform = Oid::Transform.new

    def transform : Oid::Transform
      @transform
    end

    def draw
      if self.texture?
        RayLib.draw_texture_ex(
          self.texture.value,
          self.transform.position.to_v2,
          self.direction.value,
          self.texture.scale,
          RayLib::Color::WHITE
        )
      end
    end
  end
end
