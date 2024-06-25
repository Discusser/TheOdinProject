require_relative "colors"

class Board
  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @board = Array.new(rows) { Array.new(columns, -1) }
  end

  def display
    color_choices = make_color_choices
    puts " #{('?' * @columns).chars.join(' ')}\t#{color_choices[0]}"
    puts "#{'-' * ((@columns * 2) + 2)}\t#{color_choices[1]}"
    @board.each do |row|
      puts "[#{row.map { |index| Colors::INDEX_TO_STRING[index] }.join}]"
    end
  end

  def make_color_choices
    lines = []
    lines[0] = (0..7).to_a.map { |index| Colors::INDEX_TO_STRING[index] }.join
    lines[1] = (1..8).to_a.join(" ")
    lines
  end
end
