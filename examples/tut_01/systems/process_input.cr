module Oid
  module Systems
    class ProcessInput < Entitas::ReactiveSystem
      include Entitas::Systems::ExecuteSystem

      protected property contexts : Contexts
      protected property context : InputContext

      def initialize(@contexts)
        @context = @contexts.input
        @collector = get_trigger(@context)
      end

      def filter(entity : InputEntity)
        entity.input?
      end

      def get_trigger(context : Entitas::Context) : Entitas::ICollector
        context.create_collector(InputMatcher.input)
      end

      def execute(entities : Array(Entitas::IEntity))
        # TODO: delete piece where input is over
        puts entities.size unless entities.empty?
      end
    end
  end
end
