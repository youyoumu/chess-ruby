require './lib/chessman.rb'

class Knight
  include Chessman
  attr_accessor :coord, :color, :icon, :is_captured, :name
  def initialize(coord, color)
    @coord = coord
    @color = color
    @icon = color ? " ♘ " : " ♞ "
    @is_captured = false
    @name = 'Knight'
  end
end
