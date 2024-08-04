require_relative "../lib/player"

describe HumanPlayer do
  subject(:player) { described_class.new("X") }

  context "#make_move" do
    before do
      allow(player).to receive(:print)
    end

    it "returns the position as an array of 0-indexed positions" do
      allow(player).to receive(:gets).and_return("2 1")
      expect(player.make_move).to eql([1, 0])
    end

    context "it prompts for another move" do
      it "when the response does not have 2 positions" do
        allow(player).to receive(:gets).and_return("1", "2", "2 3")
        expect(player.make_move).to eql([1, 2])
      end

      it "when the response is not entirely composed of numbers" do
        allow(player).to receive(:gets).and_return("bfsf", "ab 4.5", "2 3")
        expect(player.make_move).to eql([1, 2])
      end

      it "when the response is not composed of positive numbers" do
        allow(player).to receive(:gets).and_return("-3", "-1 1", "-2 -1", "2 3")
        expect(player.make_move).to eql([1, 2])
      end
    end
  end
end

describe ComputerPlayer do
  subject(:player) { described_class.new("O") }
  context "#make_move" do
    it "calls rand(0..2) twice" do
      expect(player).to receive(:rand).with(0..2).twice
      player.make_move
    end
  end
end
