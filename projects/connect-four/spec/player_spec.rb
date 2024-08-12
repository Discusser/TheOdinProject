require_relative "../lib/player"
require_relative "../lib/controller"

describe Player do
  subject(:player) { described_class.new("X") }
  let(:board) { Board.new(ROWS, COLUMNS) }

  context "#make_move" do
    it "gets user input" do
      allow(player).to receive(:gets).and_return("3")
      expect(player).to receive(:gets)
      player.make_move(board)
    end

    it "rejects out of bounds inputs" do
      allow(player).to receive(:gets).and_return("10", "3")
      expect(player.make_move(board)).to eql(2)
    end

    it "rejects non integer inputs" do
      allow(player).to receive(:gets).and_return("10.2", "3")
      expect(player.make_move(board)).to eql(2)
    end

    it "rejects incorrect size inputs" do
      allow(player).to receive(:gets).and_return("5 2", "3")
      expect(player.make_move(board)).to eql(2)
    end
  end
end
