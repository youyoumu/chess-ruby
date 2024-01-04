class Pawn
  attr_accessor :coord, :color, :icon
  def initialize(coord, color)
    @coord = coord
    @color = color
    @icon = color ? " ♙ " : " ♟︎ "
    @is_captured = false
  end
end
