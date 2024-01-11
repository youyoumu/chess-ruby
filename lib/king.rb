# frozen_string_literal: true

require './lib/chessman'

class King
  include Chessman
  attr_accessor :coord, :color, :icon, :is_captured, :name, :arr_castling, :first_move_available

  def initialize(coord, color)
    @coord = coord
    @color = color
    @icon = color ? ' ♔ ' : ' ♚ '
    @is_captured = false
    @name = 'King'
    @first_move_available = true
    @arr_castling = []
  end

  def coord_valid?(coord, board_obj)
    arr_move = generate_move(board_obj)
    arr_capture = generate_capture(board_obj)
    arr = arr_move + arr_capture + @arr_castling
    return true if arr.include?(coord)

    false
  end

  def move(coord)
    @coord = coord
  end

  def capture(coord, board_obj)
    @first_move_available = false
    board_obj[coord[0]][coord[1]].captured
    @coord = coord
  end

  def castling(coord, board_obj)
    @coord = coord
    if @color
      if @coord[1] == 6
        board_obj[7][7].coord = [7, 5]
      else
        board_obj[7][0].coord = [7, 3]
      end
    else
      if @coord[1] == 6
        board_obj[0][7].coord = [0, 5]
      else
        board_obj[0][0].coord = [0, 3]
      end
    end
  end

  def take_turn(coord, board_obj)
    @first_move_available = false
    arr_move = generate_move(board_obj)
    arr_capture = generate_capture(board_obj)
    if arr_move.include?(coord)
      move(coord)
    elsif arr_capture.include?(coord)
      capture(coord, board_obj)
    else
      castling(coord, board_obj)
    end
  end

  def generate_move(board_obj)
    arr = []
    coord = [@coord[0] - 1, @coord[1] - 1]
    arr << coord if in_bound?(coord) && board_obj[coord[0]][coord[1]].nil?
    coord = [@coord[0] - 1, @coord[1] + 1]
    arr << coord if in_bound?(coord) && board_obj[coord[0]][coord[1]].nil?
    coord = [@coord[0] + 1, @coord[1] - 1]
    arr << coord if in_bound?(coord) && board_obj[coord[0]][coord[1]].nil?
    coord = [@coord[0] + 1, @coord[1] + 1]
    arr << coord if in_bound?(coord) && board_obj[coord[0]][coord[1]].nil?
    coord = [@coord[0] - 1, @coord[1]]
    arr << coord if in_bound?(coord) && board_obj[coord[0]][coord[1]].nil?
    coord = [@coord[0], @coord[1] - 1]
    arr << coord if in_bound?(coord) && board_obj[coord[0]][coord[1]].nil?
    coord = [@coord[0] + 1, @coord[1]]
    arr << coord if in_bound?(coord) && board_obj[coord[0]][coord[1]].nil?
    coord = [@coord[0], @coord[1] + 1]
    arr << coord if in_bound?(coord) && board_obj[coord[0]][coord[1]].nil?
    arr
  end

  def generate_capture(board_obj)
    arr = []
    coord = [@coord[0] - 1, @coord[1] - 1]
    if @color
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && !board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] - 1, @coord[1] + 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && !board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] + 1, @coord[1] - 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && !board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] + 1, @coord[1] + 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && !board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] - 1, @coord[1]]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && !board_obj[coord[0]][coord[1]].color
      coord = [@coord[0], @coord[1] - 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && !board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] + 1, @coord[1]]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && !board_obj[coord[0]][coord[1]].color
      coord = [@coord[0], @coord[1] + 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && !board_obj[coord[0]][coord[1]].color
    else
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] - 1, @coord[1] + 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] + 1, @coord[1] - 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] + 1, @coord[1] + 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] - 1, @coord[1]]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && board_obj[coord[0]][coord[1]].color
      coord = [@coord[0], @coord[1] - 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && board_obj[coord[0]][coord[1]].color
      coord = [@coord[0] + 1, @coord[1]]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && board_obj[coord[0]][coord[1]].color
      coord = [@coord[0], @coord[1] + 1]
      arr << coord if in_bound?(coord) && !board_obj[coord[0]][coord[1]].nil? && board_obj[coord[0]][coord[1]].color
    end
    arr
  end
end
