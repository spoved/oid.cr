module Oid
  module Service
    module Application
      include Oid::Service

      property init_hook : Proc(Oid::Controller::Application, Nil) = ->(cont : Oid::Controller::Application) {}
      property update_hook : Proc(Oid::Controller::Application, Nil) = ->(cont : Oid::Controller::Application) {}
      property draw_hook : Proc(Oid::Controller::Application, Nil) = ->(cont : Oid::Controller::Application) {}
      property draw_ui_hook : Proc(Oid::Controller::Application, Nil) = ->(cont : Oid::Controller::Application) {}
      property cleanup_hook : Proc(Oid::Controller::Application, Nil) = ->(cont : Oid::Controller::Application) {}
      property exit_hook : Proc(Oid::Controller::Application, Nil) = ->(cont : Oid::Controller::Application) {}

      abstract def init_controller(contexts : Contexts) : Oid::Controller::Application
    end
  end
end
