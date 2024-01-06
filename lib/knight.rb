class Knight
  attr_accessor :coord, :color, :icon,  :is_captured
  def initialize(coord, color)
    @coord = coord
    @color = color
    @icon = color ? " ♘ " : " ♞ "
    @is_captured = false
  end
end
