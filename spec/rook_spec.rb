# frozen_string_literal: true

require './lib/board'

describe Rook do
  subject(:game) { Board.new('Player 1', 'Player 2') }
  let(:obj) { game.instance_variable_get(:@board_obj) }
  let(:playerw) { game.instance_variable_get(:@playerw) }
  let(:playerb) { game.instance_variable_get(:@playerb) }
  let(:rookw1) { playerw.instance_variable_get(:@rook1) }
  let(:pawnw1) { playerw.instance_variable_get(:@pawn1) }
  let(:pawnb7) { playerb.instance_variable_get(:@pawn7) }

  describe '#generate_move' do
    context 'when setup #1' do
      before do
        game.update
        pawnw1.move([4, 0])
        game.update
        game.draw_board
      end
      it 'generate correct move for setup #1' do
        expect(rookw1.generate_move(obj)).to match_array([[5, 0], [6, 0]])
      end
    end

    context 'when setup #2' do
      before do
        game.update
        pawnw1.move([4, 0])
        game.update
        rookw1.move([5, 0])
        game.update
        game.draw_board
      end
      it 'generate correct move for setup #2' do
        expect(rookw1.generate_move(obj)).to match_array([[5, 1], [5, 2], [5, 3], [5, 4], [5, 5], [5, 6], [5, 7],
                                                          [6, 0], [7, 0]])
      end
    end
  end

  describe '#generate_capture' do
    context 'when setup #1' do
      before do
        game.update
        pawnw1.move([4, 0])
        game.update
        game.draw_board
      end
      it 'generate correct capture for setup #1' do
        expect(rookw1.generate_capture(obj)).to match_array([])
      end
    end
  end

  context 'when setup #2' do
    before do
      game.update
      pawnw1.move([4, 0])
      game.update
      rookw1.move([5, 0])
      game.update
      rookw1.move([5, 1])
      game.update
      game.draw_board
    end
    it 'generate correct capture for setup #2' do
      expect(rookw1.generate_capture(obj)).to match_array([[1, 1]])
    end
  end

  context 'when setup #3' do
    before do
      game.update
      pawnw1.move([4, 0])
      game.update
      rookw1.move([5, 0])
      game.update
      rookw1.move([5, 1])
      pawnb7.captured
      game.update
      rookw1.move([1, 1])
      game.update
      game.draw_board
    end
    it 'generate correct capture for setup #2' do
      expect(rookw1.generate_capture(obj)).to match_array([[1, 0], [0, 1], [1, 2]])
    end
  end
end
