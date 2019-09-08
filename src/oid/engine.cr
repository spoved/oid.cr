require "./engine/*"

module Oid
  extend self

  spoved_logger

  class_getter contexts : Contexts = Entitas::Contexts.shared_instance

  # Shortcut to return the `GlobalContext`
  def global_context : GlobalContext
    self.contexts.global
  end

  # Will return true if the `GlobalContext` has a window
  def window? : Bool
    self.global_context.has_window?
  end

  # Will return the `Oid::Window` of the `GlobalContext`
  #
  # ```
  # Oid.new_window(title: "Example Window")
  #
  # Oid.window # => Oid::Window(Example Window)
  # ```
  def window
    self.global_context.window
  end

  # Will create a new `Oid::Window` in the `GlobalContext`
  #
  # ```
  # Oid.new_window(title: "Example Window") # => Oid::Window(Example Window)
  # ```
  def new_window(**args) : Oid::Window
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
