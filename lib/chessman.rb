module Chessman
  def in_bound?(coord)
    return true if coord[0] >= 0 && coord[0] <= 7 && coord[1] >= 0 && coord[1] <= 7
    false
  end

  def captured
    @is_captured = true
    @coord = nil
  end
end
