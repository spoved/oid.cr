class Example::WorldSystem < Example::Systems::WorldSystem
  def init
    # ////////////////////////////////////////////////////
    # TODO: Initialize your world here!
    # ////////////////////////////////////////////////////

    contexts.scene.create_entity
      .add_scene(name: "main", default: true)
    contexts.scene.create_entity
      .add_scene(name: "game")
  end

  def execute
  end
end
