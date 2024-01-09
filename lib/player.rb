require "./lib/king.rb"
require "./lib/queen.rb"
require "./lib/bishop.rb"
require "./lib/knight.rb"
require "./lib/rook.rb"
require "./lib/pawn.rb"

class Player
  attr_accessor :pieces, :name, :color, :king

  def initialize(name, color)
    @name = name

    #false for black, true for white
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

  end

  def update_pieces
    @pieces = @pieces.reject do |piece|
      piece.is_captured
    end
  end

  def is_attacking?(king_coord, board_obj)
    @pieces.each do |piece|
      arr = piece.generate_capture(board_obj)
      return true if arr.include?(king_coord)
    end
    false
  end

  def clone_pieces
    pieces = []
    @pieces.each do |piece|
      pieces << piece.dup
    end
    @pieces = pieces
  end

  def checkmate?(playerw, playerb, board_obj)
    check_arr = []
    @pieces.each do |piece|
      coord = piece.coord
      targets = []
      targets = piece.generate_move(board_obj) + piece.generate_capture(board_obj)

      targets.each do |target|
        playerw_dupe = playerw.dup
        playerb_dupe = playerb.dup
        playerw_dupe.clone_pieces
        playerb_dupe.clone_pieces

        board_obj_dupe = generate_board_obj(playerw_dupe, playerb_dupe)

        chessman = nil
        playerw_dupe.pieces.each do |piece_dupe|
          chessman = piece_dupe if piece_dupe.coord == coord
        end
        playerb_dupe.pieces.each do |piece_dupe|
          chessman = piece_dupe if piece_dupe.coord == coord
        end

        p chessman
        p chessman.coord
        chessman.take_turn(target, board_obj_dupe)
        playerw_dupe.update_pieces
        playerb_dupe.update_pieces

        p chessman.coord
        p playerb_dupe.king.coord

        board_obj_dupe = generate_board_obj(playerw_dupe, playerb_dupe)
        if @color
          check_arr << playerb_dupe.is_attacking?(playerw_dupe.king.coord, board_obj_dupe)
        else
          check_arr << playerw_dupe.is_attacking?(playerb_dupe.king.coord, board_obj_dupe)
        end
      end
    end
    p check_arr
    return !check_arr.include?(false)
  end

  def generate_board_obj(playerw, playerb)
    board_obj = Array.new(8) { Array.new(8, nil)}
    playerw.pieces.each do |piece|
      board_obj[piece.coord[0]][piece.coord[1]] = piece
    end
    playerb.pieces.each do |piece|
      board_obj[piece.coord[0]][piece.coord[1]] = piece
    end
    board_obj
  end
end
