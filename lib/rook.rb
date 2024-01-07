require './lib/chessman.rb'

class Rook
  include Chessman
  attr_accessor :coord, :color, :icon, :is_captured, :name
  def initialize(coord, color)
    @coord = coord
    @color = color
    @icon = color ? " ♖ " : " ♜ "
    @is_captured = false
    @name = 'Rook'
  end

  def move(coord)
    @coord = coord
  end

  def generate_move(board_obj)
    generate_move_up(board_obj) + generate_move_down(board_obj) +
    generate_move_left(board_obj) + generate_move_right(board_obj)
  end

  def generate_move_up(board_obj)
    arr = []
    move_coord = @coord
    board_obj[move_coord[0]][move_coord[1]] = nil
    while in_bound?(move_coord) && board_obj[move_coord[0]][move_coord[1]].nil?
      move_coord = [move_coord[0] - 1, move_coord[1]]
      arr << move_coord if in_bound?(move_coord) && board_obj[move_coord[0]][move_coord[1]].nil?
    end
    arr
  end

  def generate_move_down(board_obj)
    arr = []
    move_coord = @coord
    board_obj[move_coord[0]][move_coord[1]] = nil
    while in_bound?(move_coord) && board_obj[move_coord[0]][move_coord[1]].nil?
      move_coord = [move_coord[0] + 1, move_coord[1]]
      arr << move_coord if in_bound?(move_coord) && board_obj[move_coord[0]][move_coord[1]].nil?
    end
    arr
  end

  def generate_move_left(board_obj)
    arr = []
    move_coord = @coord
    board_obj[move_coord[0]][move_coord[1]] = nil
    while in_bound?(move_coord) && board_obj[move_coord[0]][move_coord[1]].nil?
      move_coord = [move_coord[0], move_coord[1] - 1]
      arr << move_coord if in_bound?(move_coord) && board_obj[move_coord[0]][move_coord[1]].nil?
    end
    arr
  end

  def generate_move_right(board_obj)
    arr = []
    move_coord = @coord
    board_obj[move_coord[0]][move_coord[1]] = nil
    while in_bound?(move_coord) && board_obj[move_coord[0]][move_coord[1]].nil?
      move_coord = [move_coord[0], move_coord[1] + 1]
      arr << move_coord if in_bound?(move_coord) && board_obj[move_coord[0]][move_coord[1]].nil?
    end
    arr
  end
end
