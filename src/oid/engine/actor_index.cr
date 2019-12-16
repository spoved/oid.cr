class Entitas::Contexts
  GAME_ACTOR_NAME_INDEX = "GameActorNameIndex"

  @[Entitas::PostConstructor]
  def init_actor_name_entity_indicies
    game.add_entity_index(
      Entitas::PrimaryEntityIndex(GameEntity, String).new(
        GAME_ACTOR_NAME_INDEX,
        game.get_group(
          GameMatcher
            .all_of(GameMatcher.actor)
            .none_of(GameMatcher.destroyed)
        ),
        ->(entity : GameEntity, component : Entitas::IComponent?) {
          component.nil? ? entity.actor.name : component.as(Actor).name
        }
      )
    )
  end

  def get_game_actor_with_name(context : GameContext, name : String) : GameEntity?
    context.get_entity_index(GAME_ACTOR_NAME_INDEX).get_entity(name)
  end
end

macro finished
  class ::GameContext < Entitas::Context(::GameEntity)
    def get_game_actor_with_name(name : String) : GameEntity?
      self.get_entity_index(Entitas::Contexts::GAME_ACTOR_NAME_INDEX)
        .as(Entitas::PrimaryEntityIndex(GameEntity, String))
        .get_entity(name)
    end
  end
end
