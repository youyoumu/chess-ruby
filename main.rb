require "./lib/board.rb"

game = Board.new('Player 1', 'Player 2')
game.draw_board
game.update_board_obj
game.playerw.pawn1.move([4, 0])
game.draw_board
game.update_board_obj
