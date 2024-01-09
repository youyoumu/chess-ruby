require './lib/board.rb'

describe Board do
  subject(:game) { Board.new('Shiro', 'Kuro') }
  before do
    allow(game).to receive(:gets).and_return('e2e4', 'e7e5', 'd1h5', 'b8c6', 'f1c4', 'g8f6', 'h5f7').exactly(7).times
  end

  it "test1" do
    game.play
    expect(1).to eq 1
  end

end
