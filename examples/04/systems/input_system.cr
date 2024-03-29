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
        when Oid::Enum::Key::Space
          if e.key_pressed?
            if contexts.stage.state.pause? && contexts.stage.state.pause
              contexts.stage.state.pause = false
            else
              contexts.stage.state.pause = true
            end
          end
        else
          puts "Input received from #{e.keyboard.key} !!!"
        end
      end
    end
  end
end
