module Oid::Element
  struct Text
    include Oid::Element

    property text : String
    property font_size : Int32
    property color : Oid::Color

    def initialize(@text, @font_size, @color); end
  end
end
