require "math"

module Math
  # Rad2Deg = 360 / (PI * 2)
  def self.rad2deg
    (360 / (::Math::PI * 2))
  end

  def self.deg2rad(deg)
    deg * ::Math::PI / 180.0
  end
end
