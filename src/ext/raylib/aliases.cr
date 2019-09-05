require "./binding"

module RayLib
  alias Color = RayLib::Binding::Color
  alias Vector2 = RayLib::Binding::Vector2
  alias Vector3 = RayLib::Binding::Vector3
  alias Vector4 = RayLib::Binding::Vector4

  # A quaternion that stores the rotation of the Transform in world space.
  alias Quaternion = RayLib::Binding::Vector4
end
