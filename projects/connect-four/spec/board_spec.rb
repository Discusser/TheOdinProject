require_relative "../lib/board"
require_relative "../lib/controller"

describe Board do
  subject(:board) { described_class.new(ROWS, COLUMNS) }

  context "#add_token" do
    it "rejects out of bounds position" do
      expect(board.add_token(board.columns + 1, "A")).to eql(nil)
    end

    context "when the column is full" do
      subject(:board) { described_class.new(2, COLUMNS) }
      it "rejects new tokens" do
        2.times { board.add_token(1, "A") }
        expect(board.add_token(1, "A")).to eql(nil)
      end
    end

    it "accepts tokens in non full columns" do
      expect(board.add_token(3, "A")).to eql([board.rows - 1, 3])
      expect(board.add_token(3, "A")).to eql([board.rows - 2, 3])
    end
  end
end
