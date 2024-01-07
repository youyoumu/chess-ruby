module Chessman
  def in_bound?(coord)
    return true if coord[0] >= 0 && coord[0] <= 7 && coord[1] >= 0 && coord[1] <= 7
    false
  end

  def captured
    @is_captured = true
    @coord = nil
  end

  def coord_valid?(coord, board_obj)
    arr_move = generate_move(board_obj)
    arr_capture = generate_capture(board_obj)
    arr = arr_move + arr_capture
    return true if arr.include?(coord)
    false
  end
end
