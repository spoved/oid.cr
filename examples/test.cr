require "../src/oid"

file_path = File.join(__DIR__, "tut_01/Bee.png")

RayLib.set_target_fps(60)

Oid.new_window(title: "Test")

# Start window fiber
spawn do
  Oid.window.start do
  end
end

# Yield to the window
while Oid.window.visable?
  Fiber.yield
end
