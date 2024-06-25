require_relative "colors"

class Board
  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @current_row = rows - 1
    @board = Array.new(rows) { Array.new(columns, -1) }
    @guess_informations = Array.new(rows)
  end

  def display(secret_code)
    color_choices = make_color_choices
    display_secret_code(secret_code, color_choices)
    puts "#{'-' * ((@columns * 2) + 2)}\t#{color_choices[1]}"
    @board.each_index do |index|
      display_row(index)
    end
  end

  def display_secret_code(secret_code, color_choices)
    secret_code = if secret_code.nil?
                    ("?" * @columns).chars.join(" ")
                  else
                    Colors.indices_to_strings(secret_code).join
                  end
    puts " #{secret_code} \t#{color_choices[0]}"
  end

  def display_row(index)
    print "[#{Colors.indices_to_strings(@board[index]).join}]"
    unless @guess_informations[index].nil?
      print "\t#{@guess_informations[index]&.correct_pos_and_color}🔴"
      print "\t#{@guess_informations[index]&.correct_color}⚪"
    end
    puts
  end

  def add_guess(guess, guess_information)
    @board[@current_row] = guess
    @guess_informations[@current_row] = guess_information
    @current_row = [0, @current_row - 1].max
  end

  def make_color_choices
    lines = []
    lines[0] = Colors.indices_to_strings(0...Colors::COLORS.length).to_a.join
    lines[1] = (1..Colors::COLORS.length).to_a.join(" ")
    lines
  end
end
