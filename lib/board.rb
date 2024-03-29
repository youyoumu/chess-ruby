# frozen_string_literal: true

require './lib/string'
require './lib/player'

class Board
  attr_accessor :board_obj, :playerw, :playerb

  def initialize(name1, name2)
    @playerw = Player.new(name1, true)
    @playerb = Player.new(name2, false)
    @board = Array.new(8) { Array.new(8, '   ') }
    @board_obj = Array.new(8) { Array.new(8, nil) }
    @black_first = false
  end

  def draw_board
    update_board
    puts '    A  B  C  D  E  F  G  H '
    counter = 8
    @board.each_with_index do |row, i|
      arr = [" #{counter} "]
      if i.even?
        row.each_with_index do |square, j|
          arr << (j.even? ? square.light : square.dark)
        end
      else
        row.each_with_index do |square, j|
          arr << (j.even? ? square.dark : square.light)
        end
      end
      arr << " #{counter} "
      puts arr.join('')
      counter -= 1
    end
    puts '    A  B  C  D  E  F  G  H '
  end

  def play
    update
    play_black_first if @black_first
    draw_board
    if playerw.checkmate?(@playerw, @playerb, @board_obj)
      puts "Check mate! #{@playerb.name} wins!"
      return
    end
    announch_check
    loop do
      update
      return 'save' if take_turnw == 'save'

      update
      draw_board
      if playerb.checkmate?(@playerw, @playerb, @board_obj)
        puts "Check mate! #{@playerw.name} wins!"
        return
      end
      announch_check
      if take_turnb == 'save'
        @black_first = true
        return 'save'
      end
      update
      draw_board
      if playerw.checkmate?(@playerw, @playerb, @board_obj)
        puts "Check mate! #{@playerb.name} wins!"
        return
      end
      announch_check
    end
  end

  def play_black_first
    @black_first = false
    draw_board
    if playerb.checkmate?(@playerw, @playerb, @board_obj)
      puts "Check mate! #{@playerw.name} wins!"
      return
    end
    announch_check
    if take_turnb == 'save'
      @black_first = true
      return 'save'
    end
    update
  end

  def announch_check
    puts "Warning! #{@playerb.name}'s King is under attack!" if @playerw.is_attacking?(@playerb.king.coord, @board_obj)
    puts "Warning! #{@playerw.name}'s King is under attack!" if @playerb.is_attacking?(@playerw.king.coord, @board_obj)
  end

  def take_turnw
    input = nil
    coords = nil
    chessman = nil
    @playerw.set_castling(@playerw, @playerb, @board_obj)
    loop do
      loop do
        puts "#{@playerw.name}'s turn:"
        input = gets.chomp
        return 'save' if input.downcase == 'save'
        break if input_valid?(input)

        puts 'Wrong format! Try again:'
      end
      coords = translate(input)
      chessman = find_chessman(coords[0])
      break if !chessman.nil? && chessman.coord_valid?(coords[1], @board_obj) && chessman.color &&
               !playerw.suicide?(@playerw, @playerb, coords)

      if chessman.nil?
        puts 'You selected empty square! Try again:'
      elsif !chessman.color
        puts "That chessman is not your's! Try again:"
      elsif !chessman.coord_valid?(coords[1], @board_obj)
        puts "That #{chessman.name} can't get to that location! Try again:"
      else
        puts "That's a suicide! Try again:"
      end
    end

    @playerw.cancel_en_passant_vulnerability
    chessman.take_turn(coords[1], @board_obj)
    @playerw.promote_pawn
  end

  def take_turnb
    input = nil
    coords = nil
    chessman = nil
    @playerb.set_castling(@playerw, @playerb, @board_obj)
    loop do
      loop do
        puts "#{@playerb.name}'s turn:"
        input = gets.chomp
        return 'save' if input.downcase == 'save'
        break if input_valid?(input)

        puts 'Wrong format! Try again:'
      end
      coords = translate(input)
      chessman = find_chessman(coords[0])
      break if !chessman.nil? && chessman.coord_valid?(coords[1], @board_obj) && !chessman.color &&
               !playerb.suicide?(@playerw, @playerb, coords)

      if chessman.nil?
        puts 'You selected empty square! Try again:'
      elsif chessman.color
        puts "That chessman is not your's! Try again:"
      elsif !chessman.coord_valid?(coords[1], @board_obj)
        puts "That #{chessman.name} can't get to that location! Try again:"
      else
        puts "That's a suicide! Try again:"
      end
    end

    @playerb.cancel_en_passant_vulnerability
    chessman.take_turn(coords[1], @board_obj)
    @playerb.promote_pawn
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
    @board = Array.new(8) { Array.new(8, '   ') }
    @playerw.pieces.each do |piece|
      @board[piece.coord[0]][piece.coord[1]] = piece.icon
    end
    @playerb.pieces.each do |piece|
      @board[piece.coord[0]][piece.coord[1]] = piece.icon
    end
  end

  def update_board_obj
    @board_obj = Array.new(8) { Array.new(8, nil) }
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

    [start, target]
  end

  def input_valid?(str_input)
    valid_int = [1, 2, 3, 4, 5, 6, 7, 8]
    valid_letter = %w[a b c d e f g h]
    unless str_input.length == 4 &&
           valid_int.include?(str_input[1].to_i) &&
           valid_int.include?(str_input[3].to_i) &&
           valid_letter.include?(str_input[0].downcase) &&
           valid_letter.include?(str_input[2].downcase)

      return false
    end

    true
  end
end
