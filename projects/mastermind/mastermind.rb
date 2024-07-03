require_relative "colors"
require_relative "board"
require_relative "guess"
require_relative "player"

class Mastermind
  ROWS = 12
  COLUMNS = 4

  def initialize(player)
    @board = Board.new(ROWS, COLUMNS)
    @moves_played = 0
    @player = player
    @secret_code = @player.make_secret_code(@board.make_color_choices, COLUMNS)

    if ARGV.include?("--debug")
      p @secret_code
      puts Colors.indices_to_strings(@secret_code).join
    end

    next_move
  end

  def next_move
    @board.display(nil) unless @player.is_a? ComputerPlayer
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
    @player.win_message(@moves_played)
  end

  def lose_game
    @board.display(@secret_code)
    @player.lose_message
  end
end

player = nil
loop do
  print "Would you like to:
  \tguess a secret code (1),
  \tmake the computer guess a code (2), or
  \tmake the computer guess a random code (3)? "
  answer = gets.chomp.to_i
  case answer
  when 1
    player = HumanPlayer.new
    break
  when 2
    player = ComputerPlayer.new(Strategy::Swaszek.new(Mastermind::COLUMNS))
    break
  when 3
    player = ComputerPlayer.new(Strategy::Swaszek.new(Mastermind::COLUMNS))
    player.make_random_code = true
    break
  end
end
Mastermind.new(player)
