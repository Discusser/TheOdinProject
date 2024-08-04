require_relative "../lib/tic_tac_toe"
require_relative "../lib/player"

describe TicTacToe do
  subject(:game) { described_class.new }

  context "#start_game" do
    it "calls next_move" do
      expect(game).to receive(:next_move)
      game.start_game
    end
  end

  context "#next_move" do
    before do
      allow(game).to receive(:winner?).and_return(true)
      allow(game).to receive(:wait_for_move).and_return(true)
      allow(game.instance_variable_get(:@board)).to receive(:display)
    end

    it "calls wait_for_move" do
      expect(game).to receive(:wait_for_move)
      game.next_move
    end

    context "returns nil if" do
      it "someone won" do
        allow(game).to receive(:winner?).and_return(true)
        expect(game.next_move).to eql(nil)
      end
      it "there is a tie" do
        allow(game).to receive(:winner?).and_return(false)
        allow(game.instance_variable_get(:@board)).to receive(:tie?).and_return(true)
        expect(game.next_move).to eql(nil)
      end
    end

    context "when the player is a human" do
      it "displays the board" do
        game.instance_variable_set(:@players, [HumanPlayer.new("X")])
        game.instance_variable_set(:@current_player_index, 0)
        expect(game.instance_variable_get(:@board)).to receive(:display)
        game.next_move
      end
    end

    context "when the player is not a human" do
      it "doesn't display the board" do
        game.instance_variable_set(:@players, [ComputerPlayer.new("O")])
        game.instance_variable_set(:@current_player_index, 0)
        expect(game.instance_variable_get(:@board)).not_to receive(:display)
        game.next_move
      end
    end
  end
end
