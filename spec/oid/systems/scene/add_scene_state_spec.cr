require "../../../spec_helper"

describe Oid::Systems::AddSceneState do
  it "adds a scene state to the entity" do
    controller = new_spec_controller
    controller.start

    entity = controller.contexts.scene.create_entity
      .add_scene(name: "main", default: true)

    entity.scene_state?.should be_false

    controller.update

    entity.scene_state?.should be_truthy
    entity.scene_state.value.should eq Oid::Enum::LoadState::Unloaded
  end
end
