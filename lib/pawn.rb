class Pawn
  attr_accessor :coord, :color, :icon
  def initialize(coord, color)
    @coord = coord
    @color = color
    @icon = color ? " ♙ " : " ♟︎ "
    @is_captured = false
    @first_move_available = true
  end

  def move(coord)
    @first_move_available = false
    @coord = coord
  end

  def coord_valid?(coord, board_obj)
    arr = generate_move(board_obj)
    return true if arr.include?(coord)
    false
  end

  def generate_move(board_obj)
    arr = []
    if @first_move_available
      if @color
        target = [@coord[0] - 2, @coord[1]]
        arr << target if board_obj[target[0]][target[1]].nil? && board_obj[target[0]+1][target[1]].nil? && target[0] >= 0
        target = [@coord[0] - 1, @coord[1]]
        arr << target if board_obj[target[0]][target[1]].nil? && target[0] >= 0
      else
        target = [@coord[0] + 2, @coord[1]]
        arr << target if board_obj[target[0]][target[1]].nil? && board_obj[target[0]-1][target[1]].nil? && target[0] <= 7
        target = [@coord[0] + 1, @coord[1]]
        arr << target if board_obj[target[0]][target[1]].nil? && target[0] <= 7
      end
    else
      if @color
        target = [@coord[0] - 1, @coord[1]]
        arr << target if board_obj[target[0]][target[1]].nil? && target[0] >= 0
      else
        target = [@coord[0] + 1, @coord[1]]
        arr << target if board_obj[target[0]][target[1]].nil? && target[0] <= 7
      end
    end
    arr
  end
end
