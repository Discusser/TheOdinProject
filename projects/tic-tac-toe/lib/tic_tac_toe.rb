require_relative "board"
require_relative "player"

class TicTacToe
  def initialize
    @players = [HumanPlayer.new("X"), ComputerPlayer.new("O")]
    @current_player_index = rand(0...@players.length)
    @board = Board.new
  end

  def start_game
    puts "The game has started!"
    next_move
  end

  def next_move
    @board.display if @players[@current_player_index].is_a? HumanPlayer
    wait_for_move

    @current_player_index = (@current_player_index + 1) % @players.length
    return if winner? || @board.tie?

    next_move
  end

  def wait_for_move
    current_player = @players[@current_player_index]

    wait_for_move unless @board.put(*current_player.make_move,
                                    current_player.character)
  end

  private

  def winner?
    @players.any? do |player|
      if @board.winning?(player)
        announce_winner(player)
        return true
      end
      false
    end
  end

  def announce_winner(player)
    @board.display
    if player.is_a? HumanPlayer
      puts "Congratulations, you won!"
    elsif player.is_a? ComputerPlayer
      puts "The computer beat you this time!"
    else
      puts "I don't know who won.."
    end
  end
end
