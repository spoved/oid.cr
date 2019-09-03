require "../src/oid"

Oid.new_window(title: "Test Window")

spawn do
  Oid.window.start
end

while Oid.window.visable?
  Fiber.yield
end

Oid.global_context.destroy_all_entities
