module Oid
  module Service
    module View
      include Oid::Service

      # create a view from a premade asset (e.g. a prefab)
      abstract def load_asset(
        contexts : Contexts,
        entity : Entity::IEntity,
        asset_type : Oid::Enum::AssetType,
        asset_name : String
      )

      abstract def update_camera(camera : Oid::Camera)

      abstract def set_camera_mode(camera : Oid::Camera3D)

      abstract def render(contexts : Contexts, entity : RenderableEntity)

      abstract def render_fps

      abstract def get_mouse_ray(mouse_position : Oid::Vector2, camera : Oid::Camera3D) : Oid::Ray

      abstract def check_mouse_collision(ray : Oid::Ray, bounding_box : Oid::BoundingBox) : Bool

      def collision_recs?(box1 : Oid::BoundingBox, box2 : Oid::BoundingBox) : Bool
        (
          box1.min.x < box2.max.x &&
            box1.max.x > box2.min.x &&
            box1.min.y < box2.max.y &&
            box1.max.y > box2.min.y
        )
      end

      # Check collision between two rectangles
      def collision_recs?(actor1 : Oid::Actor, actor2 : Oid::Actor) : Bool
        collision_recs?(actor1.bounds_rect, actor2.bounds_rect)
      end

      def collision_rec(actor1 : Oid::Actor, actor2 : Oid::Actor)
        x = 0.0
        y = 0.0
        height = 0.0
        width = 0.0

        actor1_bounds = actor1.bounds_rect
        actor2_bounds = actor2.bounds_rect

        if collision_recs?(actor1_bounds, actor2_bounds)
          data = {
            rect1: {
              x:      actor1_bounds.min.x,
              y:      actor1_bounds.min.y,
              width:  actor1_bounds.max.x - actor1_bounds.min.x,
              height: actor1_bounds.max.y - actor1_bounds.min.y,
            },
            rect2: {
              x:      actor2_bounds.min.x,
              y:      actor2_bounds.min.y,
              width:  actor2_bounds.max.x - actor2_bounds.min.x,
              height: actor2_bounds.max.y - actor2_bounds.min.y,
            },
            dxx: (actor1_bounds.min.x - actor2_bounds.min.x).abs,
            dyy: (actor1_bounds.min.y - actor2_bounds.min.y).abs,
          }

          if data[:rect1][:x] <= data[:rect2][:x]
            if data[:rect1][:y] <= data[:rect2][:y]
              x = data[:rect2][:x]
              y = data[:rect2][:y]
              width = data[:rect1][:width] - data[:dxx]
              height = data[:rect1][:height] - data[:dyy]
            else
              x = data[:rect2][:x]
              y = data[:rect1][:y]
              width = data[:rect1][:width] - data[:dxx]
              height = data[:rect2][:height] - data[:dyy]
            end
          else
            if data[:rect1][:y] <= data[:rect2][:y]
              x = data[:rect1][:x]
              y = data[:rect2][:y]
              width = data[:rect2][:width] - data[:dxx]
              height = data[:rect1][:height] - data[:dyy]
            else
              x = data[:rect1][:x]
              y = data[:rect1][:y]
              width = data[:rect2][:width] - data[:dxx]
              height = data[:rect2][:height] - data[:dyy]
            end
          end

          if data[:rect1][:width] > data[:rect2][:width]
            width = data[:rect2][:width] if width >= data[:rect2][:width]
          else
            width = data[:rect1][:width] if width >= data[:rect1][:width]
          end

          if data[:rect1][:height] > data[:rect2][:height]
            height = data[:rect2][:height] if height >= data[:rect2][:height]
          else
            height = data[:rect1][:height] if height >= data[:rect1][:height]
          end
        end

        {x: x, y: y, width: width, height: height}
      end
    end
  end
end
