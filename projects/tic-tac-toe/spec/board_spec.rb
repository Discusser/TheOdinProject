require_relative "../lib/board"
require_relative "../lib/player"

describe Board do
  before do
    allow(subject).to receive(:puts)
    allow(subject).to receive(:print)
  end

  context "when the board is empty" do
    subject(:empty_board) { described_class.new }
    context "#put" do
      it "inserts the character at the given index" do
        empty_board.put(1, 2, "hello")
        expect(empty_board.instance_variable_get(:@board)[1][2]).to eql("hello")
      end
    end

    context "#winning?" do
      let(:player) { instance_double(Player, character: "hello") }
      it "returns false" do
        expect(empty_board.winning?(player)).to eq(false)
      end
    end
  end
  context "when the board is mid-game" do
    subject(:mid_game_board) { described_class.new }

    before do
      mid_game_board.instance_variable_set(:@board, [[" ", "O", " "],
                                                     ["O", "X", "X"],
                                                     [" ", "X", "O"]])
    end

    context "#put" do
      it "doesn't insert the character if the cell is already taken and returns false" do
        expect(mid_game_board.put(1, 1, "hello")).to eq(false)
        expect(mid_game_board.instance_variable_get(:@board)[1][1]).to eql("X")
      end
    end

    context "#tie?" do
      it "returns false" do
        expect(mid_game_board.tie?).to eq(false)
      end
    end

    context "#winning?" do
      let(:x) { instance_double(Player, character: "X") }
      let(:o) { instance_double(Player, character: "X") }
      it "returns false" do
        expect(mid_game_board.winning?(x)).to eq(false)
        expect(mid_game_board.winning?(o)).to eq(false)
      end
    end
  end
  context "when the board is full" do
    subject(:tie_board) { described_class.new }
    before do
      tie_board.instance_variable_set(:@board, [%w[X O O],
                                                %w[O X X],
                                                %w[X X O]])
    end

    context "#tie?" do
      it "returns true" do
        expect(tie_board.tie?).to eq(true)
      end
    end

    context "#winning?" do
      let(:x) { instance_double(Player, character: "X") }
      let(:o) { instance_double(Player, character: "X") }
      it "returns false" do
        expect(tie_board.winning?(x)).to eq(false)
        expect(tie_board.winning?(o)).to eq(false)
      end
    end
  end
  context "when X is winning" do
    subject(:winning_board) { described_class.new }
    before do
      winning_board.instance_variable_set(:@board, [["X", "O", " "],
                                                    ["O", "X", " "],
                                                    [" ", " ", "X"]])
    end

    context "#winning?" do
      let(:x) { instance_double(Player, character: "X") }
      let(:o) { instance_double(Player, character: "O") }
      it "returns true for X" do
        expect(winning_board.winning?(x)).to eq(true)
      end
      it "returns false for O" do
        expect(winning_board.winning?(o)).to eq(false)
      end
    end

    context "#tie?" do
      it "returns false" do
        expect(winning_board.tie?).to eq(false)
      end
    end
  end
end
