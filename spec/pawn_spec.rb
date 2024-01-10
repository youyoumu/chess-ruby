# frozen_string_literal: true

require './lib/board'

describe Pawn do
  subject(:game) { Board.new('Player 1', 'Player 2') }
  let(:obj) { game.instance_variable_get(:@board_obj) }
  let(:playerw) { game.instance_variable_get(:@playerw) }
  let(:playerb) { game.instance_variable_get(:@playerb) }
  let(:pawnw1) { playerw.instance_variable_get(:@pawn1) }
  let(:pawnb7) { playerb.instance_variable_get(:@pawn7) }

  context 'when there is a chessman in front side of it' do
    before do
      game.update_board_obj
      pawnb7.move([4, 1])
      game.update_board_obj
      pawnb7.move([5, 1])
      game.update_board_obj
      game.draw_board
    end

    it 'move one square forward' do
      pawnw1.move([5, 0])
      game.draw_board
      expect(pawnw1.coord).to eq([5, 0])
    end

    it 'move two square forward' do
      pawnw1.move([4, 0])
      game.draw_board
      expect(pawnw1.coord).to eq([4, 0])
    end

    it 'capture other chessman' do
      pawnw1.capture([5, 1], obj)
      playerb.update_pieces
      game.draw_board
      expect(pawnw1.coord).to eq([5, 1])
    end
  end
end
