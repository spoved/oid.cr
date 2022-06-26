module Oid
  module DestroyableEntity
    include Components::Destroyed::Helper
  end

  module ViewableEntity
    include DestroyableEntity

    include Components::Position::Helper
    include Components::PositionType::Helper
    include Components::Rotation::Helper
    include Components::Scale::Helper
    include Components::Asset::Helper
    include Components::AssetLoaded::Helper
    include Components::View::Helper
    include Components::ViewElement::Helper
    include Components::UiElement::Helper
  end

  module MovableEntity
    include Components::Moveable::Helper
    include Components::Direction::Helper
    include Components::Mover::Helper
    include Components::Move::Helper
    include Components::MoveComplete::Helper
  end

  module InteractableEntity
    include Components::Interactive::Helper
  end

  module CollidableEntity
    include Oid::ViewableEntity
    include Oid::Components::Collidable::Helper

    # Shorcut to get `Oid::Element::BoundingBox`
    def bbox
      Oid::CollisionFuncs.bounding_box_for_entity(self)
    end
  end

  module RenderableEntity
    include Oid::Relationships(RenderableEntity)
    include Oid::Transformable
    include DestroyableEntity
    include ViewableEntity
  end
end
