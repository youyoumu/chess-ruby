require './lib/chessman.rb'

class Pawn
  include Chessman
  attr_accessor :coord, :color, :icon, :is_captured, :name
  def initialize(coord, color)
    @coord = coord
    @color = color
    @icon = color ? " ♙ " : " ♟︎ "
    @is_captured = false
    @first_move_available = true
    @name = 'Pawn'
  end

  def move(coord)
    @first_move_available = false
    @coord = coord
  end

  def capture(coord, board_obj)
    @first_move_available = false
    board_obj[coord[0]][coord[1]].captured
    @coord = coord
  end

  def take_turn(coord, board_obj)
    arr_move = generate_move(board_obj)
    arr_move.include?(coord) ? move(coord) : capture(coord, board_obj)
  end

  def coord_valid?(coord, board_obj)
    arr_move = generate_move(board_obj)
    arr_capture = generate_capture(board_obj)
    arr = arr_move + arr_capture
    return true if arr.include?(coord)
    false
  end

  def generate_move(board_obj)
    arr = []
    if @first_move_available
      if @color
        target = [@coord[0] - 2, @coord[1]]
        arr << target if board_obj[target[0]][target[1]].nil? && board_obj[target[0]+1][target[1]].nil? && in_bound?(target)
        target = [@coord[0] - 1, @coord[1]]
        arr << target if board_obj[target[0]][target[1]].nil? && in_bound?(target)
      else
        target = [@coord[0] + 2, @coord[1]]
        arr << target if board_obj[target[0]][target[1]].nil? && board_obj[target[0]-1][target[1]].nil? && in_bound?(target)
        target = [@coord[0] + 1, @coord[1]]
        arr << target if board_obj[target[0]][target[1]].nil? && in_bound?(target)
      end
    else
      if @color
        target = [@coord[0] - 1, @coord[1]]
        arr << target if board_obj[target[0]][target[1]].nil? && in_bound?(target)
      else
        target = [@coord[0] + 1, @coord[1]]
        arr << target if board_obj[target[0]][target[1]].nil? && in_bound?(target)
      end
    end
    arr
  end

  def generate_capture(board_obj)
    arr = []
    if @color
      target = [@coord[0] - 1, @coord[1] + 1]
      arr << target if !board_obj[target[0]][target[1]].nil? && !board_obj[target[0]][target[1]].color && in_bound?(target)
      target = [@coord[0] - 1, @coord[1] - 1]
      arr << target if !board_obj[target[0]][target[1]].nil? && !board_obj[target[0]][target[1]].color && in_bound?(target)
    else
      target = [@coord[0] + 1, @coord[1] + 1]
      arr << target if !board_obj[target[0]][target[1]].nil? && board_obj[target[0]][target[1]].color && in_bound?(target)
      target = [@coord[0] + 1, @coord[1] - 1]
      arr << target if !board_obj[target[0]][target[1]].nil? && board_obj[target[0]][target[1]].color && in_bound?(target)
    end
    arr
  end
end
