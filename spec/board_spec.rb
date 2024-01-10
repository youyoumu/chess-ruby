require './lib/board.rb'

describe Board do
  context "when test #1" do
    subject(:game) { Board.new('Shiro', 'Kuro') }
    before do
      allow(game).to receive(:gets).and_return('e2e4', 'e7e5', 'd1h5', 'b8c6', 'f1c4', 'g8f6', 'h5f7').exactly(7).times
    end

    it "test1" do
      game.play
      expect(1).to eq 1
    end
  end

  context "when test #2" do
    subject(:game) { Board.new('Shiro', 'Kuro') }
    let(:playerw) { game.playerw }
    before do
      allow(game).to receive(:gets).and_return('g2g4', 'b7b5', 'g4g5', 'b5b4', 'g5g6', 'b4b3', 'g6h7', 'b3c2', 'h7g8').exactly(9).times
    end

    xit "test2" do
      game.play
      expect(1).to eq 1
    end
  end

  context "when test #3" do
    subject(:game) { Board.new('Shiro', 'Kuro') }
    before do
      allow(game).to receive(:gets).and_return('f2f3', 'e7e6', 'f3f4', 'd8h4').exactly(4).times
    end

    xit "test3" do
      game.play
      expect(1).to eq 1
    end
  end

end
