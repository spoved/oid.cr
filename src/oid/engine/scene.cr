module Oid
  module IScene
    abstract def actors : Indexable(Oid::IActor)
    abstract def stage : Oid::IStage
  end
end
