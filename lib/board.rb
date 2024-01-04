require "./lib/string.rb"
require "./lib/player.rb"

class Board
  def initialize(name1, name2)
    @playerw = Player.new(name1, true)
    @playerb = Player.new(name2, false)
    @board = Array.new(8) { Array.new(8, "   ")}
  end

  def draw_board
    update_board
    puts "    A  B  C  D  E  F  G  H "
    counter = 8
    @board.each_with_index do |row, i|
      if i.even?
        arr = [" #{counter} "]
        row.each_with_index do |square, j|
          j.even? ? arr << square.light : arr << square.dark
        end
        arr << " #{counter} "
        puts arr.join('')
        counter -= 1
      else
        arr = [" #{counter} "]
        row.each_with_index do |square, j|
          j.even? ? arr << square.dark : arr << square.light
        end
        arr << " #{counter} "
        puts arr.join('')
        counter -= 1
      end
    end
    puts "    A  B  C  D  E  F  G  H "
  end

  def update_board
    @playerw.pieces.each do |piece|
      @board[piece.coord[0]][piece.coord[1]] = piece.icon
    end
    @playerb.pieces.each do |piece|
      @board[piece.coord[0]][piece.coord[1]] = piece.icon
    end
  end

  def translate(str_input)
    row_start = 8 - str_input[1].to_i
    column_start = str_input[0].downcase.ord - 97
    row_target = 8 - str_input[3].to_i
    column_target = str_input[2].downcase.ord - 97

    start = [row_start, column_start]
    target = [row_target, column_target]

    [start,target]
  end

  def input_valid?(str_input)
    valid_int = [1, 2, 3, 4, 5, 6, 7, 8]
    valid_letter = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    unless (
      str_input.length == 4 &&
      valid_int.include?(str_input[1].to_i) &&
      valid_int.include?(str_input[3].to_i) &&
      valid_letter.include?(str_input[0].downcase) &&
      valid_letter.include?(str_input[2].downcase)
    )
      return false
    end
    true
  end
end
