require_relative "board"

class Mastermind
  ROWS = 12
  COLUMNS = 4

  def initialize
    @board = Board.new(ROWS, COLUMNS)
    @board.display
  end
end

game = Mastermind.new
