require "./lib/string.rb"

class Board
  def initialize
    @board = Array.new(8) { Array.new(8, "   ")}
  end

  def draw_board
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
end
