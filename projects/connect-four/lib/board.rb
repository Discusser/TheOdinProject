class Board
  attr_reader :rows, :columns, :board

  def initialize(rows, columns)
    @board = Array.new(rows) { Array.new(columns) { "" } }
    @rows = rows
    @columns = columns
  end

  def add_token(column, token)
    array = get_column_array(column).compact.reverse
    return nil if array.empty?

    array.each_with_index do |current_token, index|
      next unless current_token.empty?

      row = rows - index - 1
      @board[row][column] = token
      return [row, column]
    end

    nil
  end

  private

  def get_column_array(column)
    @board.map { |row| row[column] }
  end
end
