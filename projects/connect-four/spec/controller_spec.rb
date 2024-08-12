require_relative "../lib/controller"

describe Controller do
  subject(:controller) { described_class.new }

  context "#play_turn" do
    let(:player_one) { Player.new(RED) }
    let(:player_two) { Player.new(BLUE) }

    before do
      # Don't make play_turn loop infinitely
      allow(controller).to receive(:game_over?).and_return(true)
      allow(player_one).to receive(:make_move).and_return(0)
      allow(player_two).to receive(:make_move).and_return(0)
      controller.instance_variable_set(:@players, [player_one, player_two])
    end

    it "calls Display#print_board" do
      display = controller.instance_variable_get(:@display)
      allow(display).to receive(:print_board)
      expect(display).to receive(:print_board)
      controller.play_turn
    end

    it "calls Player#make_move" do
      expect(player_one).to receive(:make_move)
      controller.play_turn
    end

    it "alternates between players" do
      allow(controller).to receive(:game_over?).and_return(false, true)
      expect(player_one).to receive(:make_move).once
      expect(player_two).to receive(:make_move).once
      controller.play_turn
    end
  end

  context "#start_game" do
    it "calls play_turn" do
      expect(controller).to receive(:play_turn)
      controller.start_game
    end
  end

  context "#game_over?" do
    context "when someone has won" do
      it "returns true" do
        allow(controller).to receive(:find_winner).and_return("1")
        expect(controller.game_over?).to eql(true)
      end
    end

    context "when the game is still ongoing" do
      it "returns false" do
        allow(controller).to receive(:find_winner).and_return(nil)
        expect(controller.game_over?).to eql(false)
      end
    end
  end

  context "#find_winner" do
    it "detects a horizontal win" do
      board_instance = controller.instance_variable_get(:@board)
      board_instance.instance_variable_set(:@board, [
                                             ["", "", "", "", "", "", ""],
                                             ["", "", "", "", "", "", ""],
                                             ["", "", "", "", "", "", ""],
                                             ["", "", "2", "", "", "", ""],
                                             ["", "2", "2", "", "", "", ""],
                                             ["2", "1", "1", "1", "1", "", ""]
                                           ])
      expect(controller.find_winner).to eql("1")
    end

    it "detects a vertical win" do
      board_instance = controller.instance_variable_get(:@board)
      board_instance.instance_variable_set(:@board, [
                                             ["", "", "", "", "", "", ""],
                                             ["", "", "", "", "", "", ""],
                                             ["", "", "2", "", "", "", ""],
                                             ["", "", "2", "", "", "", ""],
                                             ["", "2", "2", "", "", "", ""],
                                             ["2", "1", "2", "1", "1", "", ""]
                                           ])
      expect(controller.find_winner).to eql("2")
    end

    it "detects a diagonal win" do
      board_instance = controller.instance_variable_get(:@board)
      board_instance.instance_variable_set(:@board, [
                                             ["", "", "", "", "", "", ""],
                                             ["", "", "", "", "", "", ""],
                                             ["", "", "1", "2", "", "", ""],
                                             ["", "", "2", "1", "", "", ""],
                                             ["", "2", "2", "2", "", "", ""],
                                             ["2", "1", "2", "1", "1", "", ""]
                                           ])
      expect(controller.find_winner).to eql("2")
    end

    it "detects no winner when the game is not over" do
      board_instance = controller.instance_variable_get(:@board)
      board_instance.instance_variable_set(:@board, [
                                             ["", "", "", "", "2", "", ""],
                                             ["", "", "", "2", "1", "", ""],
                                             ["", "", "2", "1", "2", "", ""],
                                             ["", "", "1", "1", "2", "", ""],
                                             ["", "", "1", "2", "1", "2", "1"],
                                             ["1", "", "2", "1", "1", "2", "2"]
                                           ])
      expect(controller.find_winner).to eql(nil)
    end
  end
end
