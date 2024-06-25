require_relative "colors"
require_relative "board"
require_relative "guess_information"

class Mastermind
  ROWS = 12
  COLUMNS = 4

  def initialize
    @board = Board.new(ROWS, COLUMNS)
    @secret_code = (0...Colors::COLORS.length).to_a.sample(COLUMNS)
    @moves_played = 0
    p @secret_code
    puts Colors.indices_to_strings(@secret_code).join
    next_move
  end

  def next_move
    @board.display(nil)
    guess = wait_for_guess
    guess_information = GuessInformation.from_guess(guess, @secret_code)
    @board.add_guess(guess, guess_information)

    @moves_played += 1
    next_move unless game_over?(guess_information)
  end

  def game_over?(guess_information)
    if guess_information.correct_pos_and_color == COLUMNS
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

  def wait_for_guess
    guess = []
    loop do
      print "Make a guess with #{COLUMNS} space separated digits: "
      guess = gets.chomp.split.map { |e| e.to_i - 1 }
      next if guess.length != COLUMNS || !guess.all? { |e| Colors.index_valid?(e) }

      break
    end
    guess
  end
end

Mastermind.new
