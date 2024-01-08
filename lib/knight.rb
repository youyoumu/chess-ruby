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

  def move(coord)
    @coord = coord
  end

  def capture(coord, board_obj)
    board_obj[coord[0]][coord[1]].captured
    @coord = coord
  end

  def take_turn(coord, board_obj)
    arr_move = generate_move(board_obj)
    arr_move.include?(coord) ? move(coord) : capture(coord, board_obj)
  end

  def generate_move(board_obj)
    arr = []
    coord = [@coord[0] - 2, @coord[1] - 1]
    arr << coord if in_bound?(coord) && board_obj[coord[0]][coord[1]].nil?
    coord = [@coord[0] - 2, @coord[1] + 1]
    arr << coord if in_bound?(coord) && board_obj[coord[0]][coord[1]].nil?
    coord = [@coord[0] + 2, @coord[1] - 1]
    arr << coord if in_bound?(coord) && board_obj[coord[0]][coord[1]].nil?
    coord = [@coord[0] + 2, @coord[1] + 1]
    arr << coord if in_bound?(coord) && board_obj[coord[0]][coord[1]].nil?
    coord = [@coord[0] - 1, @coord[1] - 2]
    arr << coord if in_bound?(coord) && board_obj[coord[0]][coord[1]].nil?
    coord = [@coord[0] - 1, @coord[1] + 2]
    arr << coord if in_bound?(coord) && board_obj[coord[0]][coord[1]].nil?
    coord = [@coord[0] + 1, @coord[1] - 2]
    arr << coord if in_bound?(coord) && board_obj[coord[0]][coord[1]].nil?
    coord = [@coord[0] + 1, @coord[1] + 2]
    arr << coord if in_bound?(coord) && board_obj[coord[0]][coord[1]].nil?
    p arr
    arr
  end

  def generate_capture(board_obj)
    arr = []
    if @color
      coord = [@coord[0] - 2, @coord[1] - 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && !board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] - 2, @coord[1] + 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && !board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] + 2, @coord[1] - 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && !board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] + 2, @coord[1] + 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && !board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] - 1, @coord[1] - 2]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && !board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] - 1, @coord[1] + 2]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && !board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] + 1, @coord[1] - 2]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && !board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] + 1, @coord[1] + 2]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && !board_obj[coord[0]][coord[1]].color
    else
      coord = [@coord[0] - 2, @coord[1] - 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] - 2, @coord[1] + 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] + 2, @coord[1] - 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] + 2, @coord[1] + 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] - 1, @coord[1] - 2]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] - 1, @coord[1] + 2]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] + 1, @coord[1] - 2]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] + 1, @coord[1] + 2]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && board_obj[coord[0]][coord[1]].color
    end
    p arr
    arr
  end
end
