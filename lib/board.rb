require "./lib/string.rb"
require "./lib/player.rb"

class Board
  attr_accessor :board_obj, :playerw, :playerb

  def initialize(name1, name2)
    @playerw = Player.new(name1, true)
    @playerb = Player.new(name2, false)
    @board = Array.new(8) { Array.new(8, "   ")}
    @board_obj = Array.new(8) { Array.new(8, nil)}
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

  def play
    draw_board
    loop do
      update
      take_turnw
      update
      draw_board
      announch_check
      puts playerb.checkmate?(@playerw, @playerb, @board_obj)
      take_turnb
      update
      draw_board
      announch_check
      puts playerw.checkmate?(@playerw, @playerb, @board_obj)
    end
  end

  def announch_check
    puts "Warning! #{@playerb.name}'s King is under attack!" if @playerw.is_attacking?(@playerb.king.coord, @board_obj)
    puts "Warning! #{@playera.name}'s King is under attack!" if @playerb.is_attacking?(@playerb.king.coord, @board_obj)
  end

  def take_turnw
    input = nil
    coords = nil
    chessman = nil
    loop do
      loop do
        puts "#{@playerw.name}'s turn:"
        input = gets.chomp
        break if input_valid?(input)
        puts "Wrong format! Try again:"
      end
      coords = translate(input)
      chessman = find_chessman(coords[0])
      break if !chessman.nil? && chessman.coord_valid?(coords[1], @board_obj) && chessman.color
      if chessman.nil?
        puts "You selected empty square! Try again:"
      elsif !chessman.color
        puts "That chessman is not your's! Try again:"
      else
        puts "That #{chessman.name} can't get to that location! Try again:"
      end
    end
    chessman.take_turn(coords[1], @board_obj)
  end

  def take_turnb
    input = nil
    coords = nil
    chessman = nil
    loop do
      loop do
        puts "#{@playerb.name}'s turn:"
        input = gets.chomp
        break if input_valid?(input)
        puts "Wrong format! Try again:"
      end
      coords = translate(input)
      chessman = find_chessman(coords[0])
      break if !chessman.nil? && chessman.coord_valid?(coords[1], @board_obj) && !chessman.color
      if chessman.nil?
        puts "You selected empty square! Try again:"
      elsif chessman.color
        puts "That chessman is not your's! Try again:"
      else
        puts "That #{chessman.name} can't get to that location! Try again:"
      end
    end
    chessman.take_turn(coords[1], @board_obj)
  end

  def find_chessman(coord)
    chessman = nil
    @playerw.pieces.each do |piece|
      return chessman = piece if piece.coord == coord
    end
    @playerb.pieces.each do |piece|
      return chessman = piece if piece.coord == coord
    end
    chessman
  end

  def update
    @playerw.update_pieces
    @playerb.update_pieces
    update_board_obj
  end

  def update_board
    @board = Array.new(8) { Array.new(8, "   ")}
    @playerw.pieces.each do |piece|
      @board[piece.coord[0]][piece.coord[1]] = piece.icon
    end
    @playerb.pieces.each do |piece|
      @board[piece.coord[0]][piece.coord[1]] = piece.icon
    end
  end

  def update_board_obj
    @board_obj = Array.new(8) { Array.new(8, nil)}
    @playerw.pieces.each do |piece|
      @board_obj[piece.coord[0]][piece.coord[1]] = piece
    end
    @playerb.pieces.each do |piece|
      @board_obj[piece.coord[0]][piece.coord[1]] = piece
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
