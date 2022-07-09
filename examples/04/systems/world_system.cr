class Example::WorldSystem < Example::Systems::WorldSystem
  def init
    # ////////////////////////////////////////////////////
    # TODO: Initialize your world here!
    # ////////////////////////////////////////////////////
    contexts.stage
      .create_entity
      .add_state(
        pause: false,
        collision: false
      )

    # generate_2d_grid(1000, 20.0)
  end

  def execute
    actors.each do |entity|
      entity = entity.as(StageEntity)

      # ////////////////////////////////////////////////////
      # TODO: Add game logic!
      # ////////////////////////////////////////////////////
    end
  end
end
