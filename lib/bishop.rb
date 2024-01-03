class Bishop
  def initialize(coord, color)
    @coord = coord
    @color = color
    @icon = color ? " ♗ " : " ♝ "
  end
end
