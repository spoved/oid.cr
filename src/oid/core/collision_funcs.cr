module Oid
  module CollisionFuncs
    extend CollisionFuncs

    def collision_recs?(box1 : Oid::Element::BoundingBox, box2 : Oid::Element::BoundingBox) : Bool
      (
        box1.min.x < box2.max.x &&
          box1.max.x > box2.min.x &&
          box1.min.y < box2.max.y &&
          box1.max.y > box2.min.y
      )
    end

    # Check collision between two Entites
    def collision_recs?(e1 : Oid::CollidableEntity, e2 : Oid::CollidableEntity) : Bool
      collision_recs?(bounding_box_for_element(e1), bounding_box_for_element(e2))
    end

    # Return a rectangle that is the area of overlap with the collision
    def collision_rec(e1 : Oid::CollidableEntity, e2 : Oid::CollidableEntity)
      actor1_bounds = bounding_box_for_element(e1)
      actor2_bounds = bounding_box_for_element(e2)

      if collision_recs?(actor1_bounds, actor2_bounds)
        data = rec_overlap_data(actor1_bounds, actor2_bounds)
        return calc_overlap_rec(data)
      end

      {x: 0.0, y: 0.0, width: 0.0, height: 0.0}
    end

    def calc_rec_origin(origin_type : Oid::Enum::OriginType, width, height) : Oid::Vector2
      case origin_type
      when Oid::Enum::OriginType::UpperLeft
        Oid::Vector2.new(
          x: 0.0,
          y: 0.0,
        )
      when Oid::Enum::OriginType::UpperCenter
        Oid::Vector2.new(
          x: width/2,
          y: 0.0,
        )
      when Oid::Enum::OriginType::UpperRight
        Oid::Vector2.new(
          x: width,
          y: 0.0,
        )
      when Oid::Enum::OriginType::CenterLeft
        Oid::Vector2.new(
          x: 0.0,
          y: height/2,
        )
      when Oid::Enum::OriginType::Center
        Oid::Vector2.new(
          x: width/2,
          y: height/2,
        )
      when Oid::Enum::OriginType::CenterRight
        Oid::Vector2.new(
          x: width,
          y: height/2,
        )
      when Oid::Enum::OriginType::BottomLeft
        Oid::Vector2.new(
          x: 0.0,
          y: height,
        )
      when Oid::Enum::OriginType::BottomCenter
        Oid::Vector2.new(
          x: width/2,
          y: height,
        )
      when Oid::Enum::OriginType::BottomRight
        Oid::Vector2.new(
          x: width,
          y: height,
        )
      else
        Oid::Vector2.new(
          x: 0.0,
          y: 0.0,
        )
      end
    end

    def bounding_box_for_element(e : Oid::CollidableEntity) : Oid::Element::BoundingBox
      position = e.transform
      object = e.view_element.value
      # TODO: calculate with rotation
      # rotation = e.rotation.value
      scale = e.scale.value.to_f32

      case object
      when Oid::Element::Rectangle
        width = object.width * scale
        height = object.height * scale

        origin = Oid::CollisionFuncs.calc_rec_origin(
          e.view_element.origin,
          width: width,
          height: height,
        )

        Oid::Element::BoundingBox.new(
          min: Oid::Vector3.new(
            x: position.x - origin.x,
            y: position.y - origin.y,
            z: position.z,
          ),
          max: Oid::Vector3.new(
            x: position.x + width - origin.x,
            y: position.y + height - origin.y,
            z: position.z,
          )
        )
        # when Oid::Element::Cube
        # when Oid::Element::CubeWires
      else
        raise "Cannot calculate bounding box for #{object.class}"
      end
    end

    def bounding_box_for_asset(e : Oid::CollidableEntity, asset_width, asset_height) : Oid::Element::BoundingBox
      position = e.transform
      # TODO: calculate with rotation
      # rotation = e.rotation.value
      scale = e.scale.value.to_f32

      width = asset_width * scale
      height = asset_height * scale

      origin = Oid::CollisionFuncs.calc_rec_origin(
        e.asset.origin,
        width: width,
        height: height,
      )

      Oid::Element::BoundingBox.new(
        min: Oid::Vector3.new(
          x: position.x - origin.x,
          y: position.y - origin.y,
          z: position.z,
        ),
        max: Oid::Vector3.new(
          x: position.x + width - origin.x,
          y: position.y + height - origin.y,
          z: position.z,
        )
      )
    end

    # Formats the overlap data for two `Oid::Element::BoundingBox` objects
    def rec_overlap_data(box1 : Oid::Element::BoundingBox, box2 : Oid::Element::BoundingBox)
      {
        rect1: {
          x:      box1.min.x,
          y:      box1.min.y,
          width:  box1.max.x - box1.min.x,
          height: box1.max.y - box1.min.y,
        },
        rect2: {
          x:      box2.min.x,
          y:      box2.min.y,
          width:  box2.max.x - box2.min.x,
          height: box2.max.y - box2.min.y,
        },
        dxx: (box1.min.x - box2.min.x).abs,
        dyy: (box1.min.y - box2.min.y).abs,
      }
    end

    # Calculate the orgin and size of the overlap between two rectangles
    # see `#rec_overlap_data` for +data+ format
    def calc_overlap_rec(data)
      x = 0.0
      y = 0.0
      height = 0.0
      width = 0.0

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

      {x: x, y: y, width: width, height: height}
    end
  end
end
