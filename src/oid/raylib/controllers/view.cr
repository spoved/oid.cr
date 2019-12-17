class RayLib::ViewController
  include Oid::Controller::View
  include Oid::Position::Listener
  include Oid::Destroyed::Listener

  def initialize(contexts, entity, @active = false, @position = Oid::Vector3.zero, @scale = Oid::Vector3.zero)
    init_view(contexts, entity)
  end

  def init_view(contexts, entity)
    register_listeners(entity)
  end

  def destroy_view
  end

  def register_listeners(entity : Entitas::IEntity)
    entity.add_position_listener(self)
    entity.add_destroyed_listener(self)
  end

  def on_position(entity, component : Oid::Position)
    self.position = component.value
  end

  def on_destroyed(entity, component : Oid::Destroyed)
    self.destroy_view
  end
end
