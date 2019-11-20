require "json"

module Oid
  struct Color
    def self.new(unwrap : ::Pointer(Binding::Color))
      unwrap.as(Pointer(Color)).value
    end

    def self.new(unwrap : Binding::Color)
      unwrap.unsafe_as(Color)
    end

    def to_unsafe
      unsafe_as(Binding::Color)
    end
  end
end
