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
end
