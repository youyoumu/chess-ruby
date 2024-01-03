class Bishop
  attr_accessor :coord, :color, :icon
  def initialize(coord, color)
    @coord = coord
    @color = color
    @icon = color ? " ♗ " : " ♝ "
  end
end
