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

      abstract def check_collision_ray_box(ray : Oid::Ray, bounding_box : Oid::BoundingBox) : Bool
    end
  end
end
