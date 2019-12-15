@[Context(Game)]
@[Component::Unique]
class State < Entitas::Component
  prop :scene, String
end

@[Context(Game)]
class Scene < Entitas::Component
  prop :name, String
end

@[Context(Game)]
class ActiveScene < Entitas::Component
end
