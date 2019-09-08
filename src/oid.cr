require "entitas"
require "./raylib"
require "./oid/*"

Oid.logger.level = Logger::DEBUG

# Set hooks to open/close the window when it is added to the `GlobalContext`
{% begin %}
  %group = Oid.global_context.get_group(GlobalMatcher.window)

  %group.on_entity_added do |event|
    if event.component.is_a?(Oid::Window)
      event.component.as(Oid::Window).open
    end
  end

  %group.on_entity_removed do |event|
    if event.component.is_a?(Oid::Window)
      event.component.as(Oid::Window).close
    end
  end
{% end %}
