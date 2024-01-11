# frozen_string_literal: true

require './lib/king'
require './lib/queen'
require './lib/bishop'
require './lib/knight'
require './lib/rook'
require './lib/pawn'

class Player
  attr_accessor :pieces, :name, :color, :king

  def initialize(name, color)
    @name = name

    # false for black, true for white
    @color = color

    if @color
      @king = King.new([7, 4], @color)
      @queen = Queen.new([7, 3], @color)
      @bishop1 = Bishop.new([7, 2], @color)
      @bishop2 = Bishop.new([7, 5], @color)
      @knight1 = Knight.new([7, 1], @color)
      @knight2 = Knight.new([7, 6], @color)
      @rook1 = Rook.new([7, 0], @color)
      @rook2 = Rook.new([7, 7], @color)
      @pawn1 = Pawn.new([6, 0], @color)
      @pawn2 = Pawn.new([6, 1], @color)
      @pawn3 = Pawn.new([6, 2], @color)
      @pawn4 = Pawn.new([6, 3], @color)
      @pawn5 = Pawn.new([6, 4], @color)
      @pawn6 = Pawn.new([6, 5], @color)
      @pawn7 = Pawn.new([6, 6], @color)
      @pawn8 = Pawn.new([6, 7], @color)
    else
      @king = King.new([0, 4], @color)
      @queen = Queen.new([0, 3], @color)
      @bishop1 = Bishop.new([0, 5], @color)
      @bishop2 = Bishop.new([0, 2], @color)
      @knight1 = Knight.new([0, 6], @color)
      @knight2 = Knight.new([0, 1], @color)
      @rook1 = Rook.new([0, 7], @color)
      @rook2 = Rook.new([0, 0], @color)
      @pawn1 = Pawn.new([1, 7], @color)
      @pawn2 = Pawn.new([1, 6], @color)
      @pawn3 = Pawn.new([1, 5], @color)
      @pawn4 = Pawn.new([1, 4], @color)
      @pawn5 = Pawn.new([1, 3], @color)
      @pawn6 = Pawn.new([1, 2], @color)
      @pawn7 = Pawn.new([1, 1], @color)
      @pawn8 = Pawn.new([1, 0], @color)
    end

    @pieces =
      [@king, @queen, @bishop1, @bishop2, @knight1, @knight2, @rook1, @rook2, @pawn1, @pawn2, @pawn2, @pawn3,
       @pawn4, @pawn5, @pawn6, @pawn7, @pawn8]

    @pawns = [@pawn1, @pawn2, @pawn3, @pawn4, @pawn5, @pawn6, @pawn7, @pawn8]
  end

  def cancel_en_passant_vulnerability
    @pawns.each do |pawn|
      pawn.vulnerable_to_en_passant = false
    end
  end

  def set_castling(playerw, playerb, board_obj)
    arr = []
    if @color
      coord1 = [@king.coord[0], @king.coord[1] + 1]
      coord2 = [@king.coord[0], @king.coord[1] + 2]

      if board_obj[coord1[0]][coord1[1]].nil? &&
        board_obj[coord2[0]][coord2[1]].nil? &&
        @king.first_move_available &&
        @rook2.first_move_available &&
        !playerb.is_attacking?(@king.coord, board_obj) &&
        !suicide?(playerw, playerb, [@king.coord, coord1])
      arr << coord2
      end

      coord1 = [@king.coord[0], @king.coord[1] - 1]
      coord2 = [@king.coord[0], @king.coord[1] - 2]
      coord3 = [@king.coord[0], @king.coord[1] - 3]
      if board_obj[coord1[0]][coord1[1]].nil? &&
        board_obj[coord2[0]][coord2[1]].nil? &&
        board_obj[coord3[0]][coord3[1]].nil?
        @king.first_move_available &&
        @rook1.first_move_available &&
        !playerb.is_attacking?(@king.coord, board_obj) &&
        !suicide?(playerw, playerb, [@king.coord, coord1])
      arr << coord2
      end
    else
      coord1 = [@king.coord[0], @king.coord[1] + 1]
      coord2 = [@king.coord[0], @king.coord[1] + 2]
      if board_obj[coord1[0]][coord1[1]].nil? &&
        board_obj[coord2[0]][coord2[1]].nil? &&
        @king.first_move_available &&
        @rook1.first_move_available &&
        !playerw.is_attacking?(@king.coord, board_obj) &&
        !suicide?(playerw, playerb, [@king.coord, coord1])
      arr << coord2
      end

      coord1 = [@king.coord[0], @king.coord[1] - 1]
      coord2 = [@king.coord[0], @king.coord[1] - 2]
      coord3 = [@king.coord[0], @king.coord[1] - 3]
      if board_obj[coord1[0]][coord1[1]].nil? &&
        board_obj[coord2[0]][coord2[1]].nil? &&
        board_obj[coord3[0]][coord3[1]].nil?
        @king.first_move_available &&
        @rook2.first_move_available &&
        !playerw.is_attacking?(@king.coord, board_obj) &&
        !suicide?(playerw, playerb, [@king.coord, coord1])
      arr << coord2
      end
    end
    @king.arr_castling = arr
  end

  def promote_pawn(promote_name = nil)
    if @color
      if !@pawn1.is_captured && @pawn1.coord[0].zero? && @pawn1.name == 'Pawn'
        @pawn1 = get_new_class(@pawn1.coord,
                               promote_name)
      end
      if !@pawn2.is_captured && @pawn2.coord[0].zero? && @pawn2.name == 'Pawn'
        @pawn2 = get_new_class(@pawn2.coord,
                               promote_name)
      end
      if !@pawn3.is_captured && @pawn3.coord[0].zero? && @pawn3.name == 'Pawn'
        @pawn3 = get_new_class(@pawn3.coord,
                               promote_name)
      end
      if !@pawn4.is_captured && @pawn4.coord[0].zero? && @pawn4.name == 'Pawn'
        @pawn4 = get_new_class(@pawn4.coord,
                               promote_name)
      end
      if !@pawn5.is_captured && @pawn5.coord[0].zero? && @pawn5.name == 'Pawn'
        @pawn5 = get_new_class(@pawn5.coord,
                               promote_name)
      end
      if !@pawn6.is_captured && @pawn6.coord[0].zero? && @pawn6.name == 'Pawn'
        @pawn6 = get_new_class(@pawn6.coord,
                               promote_name)
      end
      if !@pawn7.is_captured && @pawn7.coord[0].zero? && @pawn7.name == 'Pawn'
        @pawn7 = get_new_class(@pawn7.coord,
                               promote_name)
      end
      if !@pawn8.is_captured && @pawn8.coord[0].zero? && @pawn8.name == 'Pawn'
        @pawn8 = get_new_class(@pawn8.coord,
                               promote_name)
      end
    else
      if !@pawn1.is_captured && @pawn1.coord[0] == 7 && @pawn1.name == 'Pawn'
        @pawn1 = get_new_class(@pawn1.coord,
                               promote_name)
      end
      if !@pawn2.is_captured && @pawn2.coord[0] == 7 && @pawn2.name == 'Pawn'
        @pawn2 = get_new_class(@pawn2.coord,
                               promote_name)
      end
      if !@pawn3.is_captured && @pawn3.coord[0] == 7 && @pawn3.name == 'Pawn'
        @pawn3 = get_new_class(@pawn3.coord,
                               promote_name)
      end
      if !@pawn4.is_captured && @pawn4.coord[0] == 7 && @pawn4.name == 'Pawn'
        @pawn4 = get_new_class(@pawn4.coord,
                               promote_name)
      end
      if !@pawn5.is_captured && @pawn5.coord[0] == 7 && @pawn5.name == 'Pawn'
        @pawn5 = get_new_class(@pawn5.coord,
                               promote_name)
      end
      if !@pawn6.is_captured && @pawn6.coord[0] == 7 && @pawn6.name == 'Pawn'
        @pawn6 = get_new_class(@pawn6.coord,
                               promote_name)
      end
      if !@pawn7.is_captured && @pawn7.coord[0] == 7 && @pawn7.name == 'Pawn'
        @pawn7 = get_new_class(@pawn7.coord,
                               promote_name)
      end
      if !@pawn8.is_captured && @pawn8.coord[0] == 7 && @pawn8.name == 'Pawn'
        @pawn8 = get_new_class(@pawn8.coord,
                               promote_name)
      end
    end
    update_pawns
  end

  def update_pawns
    @pawns = @pawns.select do |piece|
      piece.name == 'Pawn'
    end
  end

  def get_new_class(coord, promote_name)
    input = promote_name
    if input.nil?
      puts 'Promote the Pawn! Please select one of these class: [Queen, Bishop, Knight, Rook]'
      loop do
        input = gets.chomp.downcase
        break if input_valid?(input)

        puts 'Invalid input! Try again:'
      end
    end
    case input
    when 'queen'
      Queen.new(coord, @color)
    when 'bishop'
      Bishop.new(coord, @color)
    when 'knight'
      Knight.new(coord, @color)
    when 'rook'
      Rook.new(coord, @color)
    end
  end

  def input_valid?(input)
    valid_input = %w[queen bishop knight rook]
    return true if valid_input.include?(input)

    false
  end

  def reassign_pieces
    @pieces =
      [@king, @queen, @bishop1, @bishop2, @knight1, @knight2, @rook1, @rook2, @pawn1, @pawn2, @pawn2, @pawn3,
       @pawn4, @pawn5, @pawn6, @pawn7, @pawn8]
  end

  def update_pieces
    reassign_pieces
    @pieces = @pieces.reject(&:is_captured)
    @pawns = @pawns.reject(&:is_captured)
  end

  def is_attacking?(king_coord, board_obj)
    @pieces.each do |piece|
      arr = piece.generate_capture(board_obj)
      return true if arr.include?(king_coord)
    end
    false
  end

  def suicide?(playerw, playerb, coords)
    arr_check = []
    %w[queen bishop knight rook].each do |promote_name|
      playerw_dupe = Marshal.load(Marshal.dump(playerw))
      playerb_dupe = Marshal.load(Marshal.dump(playerb))
      board_obj_dupe = generate_board_obj(playerw_dupe, playerb_dupe)

      chessman = find_chessman(playerw_dupe, playerb_dupe, coords[0])
      if @color
        playerw_dupe.cancel_en_passant_vulnerability
      else
        playerb_dupe.cancel_en_passant_vulnerability
      end
      chessman.take_turn(coords[1], board_obj_dupe)
      if @color
        playerw_dupe.promote_pawn(promote_name)
      else
        playerb_dupe.promote_pawn(promote_name)
      end
      playerw_dupe.update_pieces
      playerb_dupe.update_pieces

      board_obj_dupe = generate_board_obj(playerw_dupe, playerb_dupe)
      arr_check << if @color
                     playerb_dupe.is_attacking?(playerw_dupe.king.coord, board_obj_dupe)
                   else
                     playerw_dupe.is_attacking?(playerb_dupe.king.coord, board_obj_dupe)
                   end
    end
    return true if arr_check.all?(true)

    false
  end

  def find_chessman(playerw, playerb, coord)
    chessman = nil
    playerw.pieces.each do |piece|
      chessman = piece if piece.coord == coord
    end
    playerb.pieces.each do |piece|
      chessman = piece if piece.coord == coord
    end
    chessman
  end

  def checkmate?(playerw, playerb, board_obj)
    playerw.set_castling(playerw, playerb, board_obj)
    playerb.set_castling(playerw, playerb, board_obj)
    check_arr = []
    @pieces.each do |piece|
      coord = piece.coord
      targets = piece.generate_move(board_obj) + piece.generate_capture(board_obj)
      if piece.name == 'Pawn'
        targets += piece.generate_en_passant(board_obj)
      elsif piece.name == 'King'
        targets += piece.arr_castling
      end
      targets.each do |target|
        %w[queen bishop knight rook].each do |promote_name|
          playerw_dupe = Marshal.load(Marshal.dump(playerw))
          playerb_dupe = Marshal.load(Marshal.dump(playerb))

          board_obj_dupe = generate_board_obj(playerw_dupe, playerb_dupe)

          chessman = nil
          playerw_dupe.pieces.each do |piece_dupe|
            chessman = piece_dupe if piece_dupe.coord == coord
          end
          playerb_dupe.pieces.each do |piece_dupe|
            chessman = piece_dupe if piece_dupe.coord == coord
          end

          if @color
            playerw_dupe.cancel_en_passant_vulnerability
          else
            playerb_dupe.cancel_en_passant_vulnerability
          end
          chessman.take_turn(target, board_obj_dupe)
          if @color
            playerw_dupe.promote_pawn(promote_name)
          else
            playerb_dupe.promote_pawn(promote_name)
          end
          playerw_dupe.update_pieces
          playerb_dupe.update_pieces

          board_obj_dupe = generate_board_obj(playerw_dupe, playerb_dupe)
          check_arr << if @color
                         playerb_dupe.is_attacking?(playerw_dupe.king.coord, board_obj_dupe)
                       else
                         playerw_dupe.is_attacking?(playerb_dupe.king.coord, board_obj_dupe)
                       end
        end
      end
    end
    !check_arr.include?(false)
  end

  def generate_board_obj(playerw, playerb)
    board_obj = Array.new(8) { Array.new(8, nil) }
    playerw.pieces.each do |piece|
      board_obj[piece.coord[0]][piece.coord[1]] = piece
    end
    playerb.pieces.each do |piece|
      board_obj[piece.coord[0]][piece.coord[1]] = piece
    end
    board_obj
  end
end
