require_relative "colors"

class Board
  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @board = Array.new(rows) { Array.new(columns) { rand(0..7) } }
  end

  def display
    puts " #{('?' * @columns).chars.join(' ')}"
    puts "-" * ((@columns * 2) + 2)
    # puts " #{(1..@columns).to_a.join(' ')} "
    @board.each do |row|
      puts "[#{row.map { |index| Colors::INDEX_TO_STRING[index] }.join}]"
    end
  end
end
