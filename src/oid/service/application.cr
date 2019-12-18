module Oid
  module Service
    module Application
      include Oid::Service

      @[JSON::Field(ignore: true)]
      property init_hook : Proc(Oid::Controller::Application, Nil) = ->(cont : Oid::Controller::Application) {}
      @[JSON::Field(ignore: true)]
      property update_hook : Proc(Oid::Controller::Application, Nil) = ->(cont : Oid::Controller::Application) {}
      @[JSON::Field(ignore: true)]
      property draw_hook : Proc(Oid::Controller::Application, Nil) = ->(cont : Oid::Controller::Application) {}
      @[JSON::Field(ignore: true)]
      property draw_ui_hook : Proc(Oid::Controller::Application, Nil) = ->(cont : Oid::Controller::Application) {}
      @[JSON::Field(ignore: true)]
      property cleanup_hook : Proc(Oid::Controller::Application, Nil) = ->(cont : Oid::Controller::Application) {}
      @[JSON::Field(ignore: true)]
      property exit_hook : Proc(Oid::Controller::Application, Nil) = ->(cont : Oid::Controller::Application) {}

      abstract def init_controller(contexts : Contexts) : Oid::Controller::Application
    end
  end
end
