# frozen_string_literal: true

require './lib/chessman'

class Bishop
  include Chessman
  attr_accessor :coord, :color, :icon, :is_captured, :name

  def initialize(coord, color)
    @coord = coord
    @color = color
    @icon = color ? ' ♗ ' : ' ♝ '
    @is_captured = false
    @name = 'Bishop'
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
    generate_move_up_left(board_obj) +
      generate_move_up_right(board_obj) +
      generate_move_down_left(board_obj) +
      generate_move_down_right(board_obj)
  end

  def generate_capture(board_obj)
    generate_capture_up_left(board_obj) +
      generate_capture_up_right(board_obj) +
      generate_capture_down_left(board_obj) +
      generate_capture_down_right(board_obj)
  end

  def generate_move_up_left(board_obj)
    arr = []
    move_coord = @coord
    while in_bound?(move_coord) &&
          (board_obj[move_coord[0]][move_coord[1]].nil? ||
          board_obj[move_coord[0]][move_coord[1]] === self)

      move_coord = [move_coord[0] - 1, move_coord[1] - 1]
      arr << move_coord if in_bound?(move_coord) && board_obj[move_coord[0]][move_coord[1]].nil?
    end
    arr
  end

  def generate_move_up_right(board_obj)
    arr = []
    move_coord = @coord
    while in_bound?(move_coord) &&
          (board_obj[move_coord[0]][move_coord[1]].nil? ||
          board_obj[move_coord[0]][move_coord[1]] === self)

      move_coord = [move_coord[0] - 1, move_coord[1] + 1]
      arr << move_coord if in_bound?(move_coord) && board_obj[move_coord[0]][move_coord[1]].nil?
    end
    arr
  end

  def generate_move_down_left(board_obj)
    arr = []
    move_coord = @coord
    while in_bound?(move_coord) &&
          (board_obj[move_coord[0]][move_coord[1]].nil? ||
          board_obj[move_coord[0]][move_coord[1]] === self)

      move_coord = [move_coord[0] + 1, move_coord[1] - 1]
      arr << move_coord if in_bound?(move_coord) && board_obj[move_coord[0]][move_coord[1]].nil?
    end
    arr
  end

  def generate_move_down_right(board_obj)
    arr = []
    move_coord = @coord
    while in_bound?(move_coord) &&
          (board_obj[move_coord[0]][move_coord[1]].nil? ||
          board_obj[move_coord[0]][move_coord[1]] === self)

      move_coord = [move_coord[0] + 1, move_coord[1] + 1]
      arr << move_coord if in_bound?(move_coord) && board_obj[move_coord[0]][move_coord[1]].nil?
    end
    arr
  end

  def generate_capture_up_left(board_obj)
    arr = []
    move_coord = @coord
    if @color
      while in_bound?(move_coord) &&
            (board_obj[move_coord[0]][move_coord[1]].nil? ||
            board_obj[move_coord[0]][move_coord[1]] === self)

        move_coord = [move_coord[0] - 1, move_coord[1] - 1]
        next unless in_bound?(move_coord) &&
                    !board_obj[move_coord[0]][move_coord[1]].nil? &&
                    !board_obj[move_coord[0]][move_coord[1]].color

        arr << move_coord
      end
    else
      while in_bound?(move_coord) &&
            (board_obj[move_coord[0]][move_coord[1]].nil? ||
            board_obj[move_coord[0]][move_coord[1]] === self)

        move_coord = [move_coord[0] - 1, move_coord[1] - 1]
        next unless in_bound?(move_coord) &&
                    !board_obj[move_coord[0]][move_coord[1]].nil? &&
                    board_obj[move_coord[0]][move_coord[1]].color

        arr << move_coord
      end
    end
    arr
  end

  def generate_capture_up_right(board_obj)
    arr = []
    move_coord = @coord
    if @color
      while in_bound?(move_coord) &&
            (board_obj[move_coord[0]][move_coord[1]].nil? ||
            board_obj[move_coord[0]][move_coord[1]] === self)

        move_coord = [move_coord[0] - 1, move_coord[1] + 1]
        next unless in_bound?(move_coord) &&
                    !board_obj[move_coord[0]][move_coord[1]].nil? &&
                    !board_obj[move_coord[0]][move_coord[1]].color

        arr << move_coord
      end
    else
      while in_bound?(move_coord) &&
            (board_obj[move_coord[0]][move_coord[1]].nil? ||
            board_obj[move_coord[0]][move_coord[1]] === self)

        move_coord = [move_coord[0] - 1, move_coord[1] + 1]
        next unless in_bound?(move_coord) &&
                    !board_obj[move_coord[0]][move_coord[1]].nil? &&
                    board_obj[move_coord[0]][move_coord[1]].color

        arr << move_coord
      end
    end
    arr
  end

  def generate_capture_down_left(board_obj)
    arr = []
    move_coord = @coord
    if @color
      while in_bound?(move_coord) &&
            (board_obj[move_coord[0]][move_coord[1]].nil? ||
            board_obj[move_coord[0]][move_coord[1]] === self)

        move_coord = [move_coord[0] + 1, move_coord[1] - 1]
        next unless in_bound?(move_coord) &&
                    !board_obj[move_coord[0]][move_coord[1]].nil? &&
                    !board_obj[move_coord[0]][move_coord[1]].color

        arr << move_coord
      end
    else
      while in_bound?(move_coord) &&
            (board_obj[move_coord[0]][move_coord[1]].nil? ||
            board_obj[move_coord[0]][move_coord[1]] === self)

        move_coord = [move_coord[0] + 1, move_coord[1] - 1]
        next unless in_bound?(move_coord) &&
                    !board_obj[move_coord[0]][move_coord[1]].nil? &&
                    board_obj[move_coord[0]][move_coord[1]].color

        arr << move_coord
      end
    end
    arr
  end

  def generate_capture_down_right(board_obj)
    arr = []
    move_coord = @coord
    if @color
      while in_bound?(move_coord) &&
            (board_obj[move_coord[0]][move_coord[1]].nil? ||
            board_obj[move_coord[0]][move_coord[1]] === self)

        move_coord = [move_coord[0] + 1, move_coord[1] + 1]
        next unless in_bound?(move_coord) &&
                    !board_obj[move_coord[0]][move_coord[1]].nil? &&
                    !board_obj[move_coord[0]][move_coord[1]].color

        arr << move_coord
      end
    else
      while in_bound?(move_coord) &&
            (board_obj[move_coord[0]][move_coord[1]].nil? ||
            board_obj[move_coord[0]][move_coord[1]] === self)

        move_coord = [move_coord[0] + 1, move_coord[1] + 1]
        next unless in_bound?(move_coord) &&
                    !board_obj[move_coord[0]][move_coord[1]].nil? &&
                    board_obj[move_coord[0]][move_coord[1]].color

        arr << move_coord
      end
    end
    arr
  end
end
