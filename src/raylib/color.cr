require "json"

module Oid
  struct Color
    def self.new(unwrap : ::Pointer(RayLib::Binding::Color))
      unwrap.as(Pointer(Oid::Color)).value
    end

    def self.new(unwrap : RayLib::Binding::Color)
      unwrap.unsafe_as(Oid::Color)
    end

    def to_unsafe
      unsafe_as(RayLib::Binding::Color)
    end
  end
end
