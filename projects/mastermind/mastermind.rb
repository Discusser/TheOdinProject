require_relative "colors"
require_relative "board"
require_relative "guess"
require_relative "player"

# TODO: let computer guess the player's secret code
class Mastermind
  ROWS = 12
  COLUMNS = 4

  def initialize(player)
    @board = Board.new(ROWS, COLUMNS)
    @secret_code = (0...Colors::COLORS.length).to_a.sample(COLUMNS)
    @moves_played = 0
    @player = player
    p @secret_code
    puts Colors.indices_to_strings(@secret_code).join
    next_move
  end

  def next_move
    @board.display(nil)
    guess = Guess.new(@player.wait_for_guess(@board.previous_guesses, COLUMNS), @secret_code)
    @board.add_guess(guess)

    @moves_played += 1
    next_move unless game_over?(guess)
  end

  def game_over?(guess)
    if guess.correct_pos_and_color == COLUMNS
      win_game
      return true
    elsif @moves_played >= ROWS
      lose_game
      return true
    end
    false
  end

  def win_game
    @board.display(@secret_code)
    puts "You won in #{@moves_played} moves!"
  end

  def lose_game
    @board.display(@secret_code)
    puts "You lost! Better luck next time!"
  end
end

player = nil
loop do
  print "Would you like to guess a secret code (1) or make the computer guess a code (2)? "
  answer = gets.chomp.to_i
  if answer == 1
    player = HumanPlayer.new
    break
  elsif answer == 2
    player = ComputerPlayer.new
    break
  end
end
Mastermind.new(player)
