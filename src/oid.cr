require "entitas"
require "./ext/raylib/*"
require "./oid/*"

module Oid
  extend self

  spoved_logger

  class_getter contexts : Contexts = Entitas::Contexts.shared_instance

  def global_context : GlobalContext
    self.contexts.global
  end

  def window?
    self.global_context.window?
  end

  def window
    self.global_context.window
  end

  def new_window(**args)
    if self.window?
      e = self.global_context.window_entity.as(GlobalEntity)
      e.del_window
      e.add_window(**args)
    else
      self.global_context.window = Oid::Window.new(**args)
    end
    self.window
  end
end

Oid.logger.level = Logger::DEBUG

private def set_window_hooks
  group = Oid.global_context.get_group(GlobalMatcher.window)

  group.on_entity_added do |event|
    if event.component.is_a?(Oid::Window)
      event.component.as(Oid::Window).open
    end
  end

  group.on_entity_removed do |event|
    if event.component.is_a?(Oid::Window)
      event.component.as(Oid::Window).close
    end
  end
end

set_window_hooks
