module Oid
  module Enum
    enum Position
      Static   # the element's position is used without any translation.
      Relative # this is the default value, the element is positioned relative to its parent.
      Absolute # the element is positioned absolutely to its first parent.
      Fixed    # the element is positioned related to the root view.
    end
  end
end
