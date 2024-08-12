class Display
  def initialize(board)
    @board = board
  end

  def print_board
    0.upto(@board.rows - 1).each do |index|
      print_row(index)
    end
    print "  "
    @board.columns.times { |index| print "#{index + 1} " }
    puts
  end

  private

  def print_row(index)
    row = @board.board[index]
    print("| ")
    row.each do |elem|
      elem = "○ " if elem.empty?
      print(elem)
    end
    print("|")
    puts
  end
end
