module Oid
  module Service
    module Application
      include Oid::Service

      @[JSON::Field(ignore: true)]
      property init_hook : Proc(Contexts, Nil) = ->(contexts : Contexts) {}
      @[JSON::Field(ignore: true)]
      property update_hook : Proc(Contexts, Nil) = ->(contexts : Contexts) {}
      @[JSON::Field(ignore: true)]
      property draw_hook : Proc(Contexts, Entitas::Group(StageEntity), Nil) = ->(contexts : Contexts, render_group : Entitas::Group(StageEntity)) {}
      @[JSON::Field(ignore: true)]
      property draw_ui_hook : Proc(Contexts, Entitas::Group(StageEntity), Nil) = ->(contexts : Contexts, render_group : Entitas::Group(StageEntity)) {}
      @[JSON::Field(ignore: true)]
      property cleanup_hook : Proc(Contexts, Nil) = ->(contexts : Contexts) {}
      @[JSON::Field(ignore: true)]
      property exit_hook : Proc(Contexts, Nil) = ->(contexts : Contexts) {}

      abstract def init_controller(contexts : Contexts) : Oid::Controller::Application
    end
  end
end
