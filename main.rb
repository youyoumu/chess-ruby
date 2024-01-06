require "./lib/board.rb"

game = Board.new('Player 1', 'Player 2')
game.draw_board
game.update_board_obj
game.playerb.pawn7.move([4, 1])
game.draw_board
game.update_board_obj
game.playerb.pawn7.move([5, 1])
game.draw_board
game.update_board_obj
p game.playerw.pawn1.generate_capture(game.board_obj)
