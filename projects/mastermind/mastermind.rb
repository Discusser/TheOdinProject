require_relative "colors"
require_relative "board"

class Mastermind
  ROWS = 12
  COLUMNS = 4

  def initialize
    @board = Board.new(ROWS, COLUMNS)
    next_move
  end

  def next_move
    @board.display
    guess = wait_for_guess
    @board.add_guess(guess)

    next_move
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

game = Mastermind.new
