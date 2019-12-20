# class Example::UiSystem
#   include Entitas::Systems::InitializeSystem
#   include Entitas::Systems::ExecuteSystem

#   protected property contexts : Contexts
#   protected property context : UiContext
#   protected property actors : Entitas::Group(UiEntity)

#   include_services Config

#   def initialize(@contexts)
#     @context = @contexts.ui
#     @actors = @contexts.ui.get_group(UiMatcher.all_of(UiMatcher.actor))
#   end

#   def init
#     _init_services
#   end

#   def execute
#     actors.each do |entity|
#       entity = entity.as(UiEntity)
#       # ////////////////////////////////////////////////////
#       # TODO: Add game logic!
#       # ////////////////////////////////////////////////////
#     end
#   end
# end
