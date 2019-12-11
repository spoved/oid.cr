module Oid
  module Element
    include Oid::GameObject
  end

  class Text
    include Oid::Element

    property text : String
    property font_size : Int32
    property color : Oid::Color

    def initialize(@text, @font_size, @color); end
  end
end
