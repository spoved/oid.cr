class Example::InputSystem < Example::Systems::InputSystem
  def execute(entities : Array(Entitas::IEntity))
    entities.each do |e|
      e = e.as(InputEntity)

      if e.left_mouse? && e.mouse_pressed?
        # ////////////////////////////////////////////////////
        # TODO: Add logic for when left mouse is clicked
        # ////////////////////////////////////////////////////
      elsif e.mouse_wheel?
        # ////////////////////////////////////////////////////
        # TODO: Add logic for when mouse wheel is scrolled
        # ////////////////////////////////////////////////////
      elsif e.keyboard?
        case e.keyboard.key
        # when Oid::Enum::Key::W
        #   player.position.value += Oid::Vector3.down
        # when Oid::Enum::Key::S
        #   player.position.value += Oid::Vector3.up
        # when Oid::Enum::Key::A
        #   player.position.value += Oid::Vector3.left
        # when Oid::Enum::Key::D
        #   player.position.value += Oid::Vector3.right
        else
          puts "Input received from #{e.keyboard.key} !!!"
        end
      end
    end
  end
end
