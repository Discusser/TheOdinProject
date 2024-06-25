require_relative "colors"

class Board
  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @current_row = rows - 1
    @board = Array.new(rows) { Array.new(columns, -1) }
  end

  def display
    color_choices = make_color_choices
    puts " #{('?' * @columns).chars.join(' ')}\t#{color_choices[0]}"
    puts "#{'-' * ((@columns * 2) + 2)}\t#{color_choices[1]}"
    @board.each do |row|
      puts "[#{Colors.indices_to_strings(row).join}]"
    end
  end

  def add_guess(guess)
    @board[@current_row] = guess
    @current_row = [0, @current_row - 1].max
  end

  def make_color_choices
    lines = []
    lines[0] = Colors.indices_to_strings(0..7).to_a.join
    lines[1] = (1..8).to_a.join(" ")
    lines
  end
end
