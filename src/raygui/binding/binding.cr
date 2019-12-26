module RayGui
  # Native bindings.  Mostly generated.
  lib Binding
    # Container for string data.
    struct CrystalString
      ptr : LibC::Char*
      size : LibC::Int
    end

    # Container for a `Proc`
    struct CrystalProc
      ptr : Void*
      context : Void*
    end

    # Container for raw memory-data.  The `ptr` could be anything.
    struct CrystalSlice
      ptr : Void*
      size : LibC::Int
    end
  end

  # Helpers for bindings.  Required.
  module BindgenHelper
    # Wraps `Proc` to a `Binding::CrystalProc`, which can then passed on to C++.
    def self.wrap_proc(proc : Proc)
      Binding::CrystalProc.new(
        ptr: proc.pointer,
        context: proc.closure_data,
      )
    end

    # Wraps `Proc` to a `Binding::CrystalProc`, which can then passed on to C++.
    # `Nil` version, returns a null-proc.
    def self.wrap_proc(nothing : Nil)
      Binding::CrystalProc.new(
        ptr: Pointer(Void).null,
        context: Pointer(Void).null,
      )
    end

    # Wraps a *list* into a container *wrapper*, if it's not already one.
    macro wrap_container(wrapper, list)
      %instance = {{ list }}
      if %instance.is_a?({{ wrapper }})
        %instance
      else
        {{wrapper}}.new.concat(%instance)
      end
    end

    # Wrapper for an instantiated, sequential container type.
    #
    # This offers (almost) all read-only methods known from `Array`.
    # Additionally, there's `#<<`.  Other than that, the container type is not
    # meant to be used for storage, but for data transmission between the C++
    # and the Crystal world.  Don't let that discourage you though.
    abstract class SequentialContainer(T)
      include Indexable(T)

      # `#unsafe_at` and `#size` will be implemented by the wrapper class.

      # Adds an element at the end.  Implemented by the wrapper.
      abstract def push(value)

      # Adds *element* at the end of the container.
      def <<(value : T) : self
        push(value)
        self
      end

      # Adds all *elements* at the end of the container, retaining their order.
      def concat(values : Enumerable(T)) : self
        values.each { |v| push(v) }
        self
      end

      def to_s(io)
        to_a.to_s(io)
      end

      def inspect(io)
        io << "<Wrapped "
        to_a.inspect(io)
        io << ">"
      end
    end
  end

  @[Link(ldflags: "#{__DIR__}/../../../ext/raygui.a")]
  lib Binding
  end
end
