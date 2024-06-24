class TicTacToe
  def initialize
    initialize_board
  end

  def print_board
    print " " * (@board.length.to_s.length + 2)
    (0...@board[0].length).each do |index|
      print "#{index + 1} "
    end
    puts
    @board.each_with_index do |row, index|
      puts "#{index + 1} [#{row.join(',')}]"
    end
  end

  def start_game
    initialize_board
    puts "The game has started!"
    next_move
  end

  def next_move
    print_board if @player_to_play
    announce_turn

    @player_to_play = !@player_to_play
    return if winner? || tie?

    next_move
  end

  def announce_turn
    if @player_to_play
      puts "It is your turn to play!"
      announce_turn unless play(*prompt_player_move)
    else
      announce_turn unless play(rand(0..2), rand(0..2))
    end
  end

  def prompt_player_move
    print "Specify row and column to play, separated by a space: "
    response = gets.chomp.split.map(&:to_i)
    prompt_player_move unless response.length == 2 && response.all? { |e| e.is_a?(Integer) && e.positive? }

    response.map { |e| e - 1 }
  end

  def play(row, column)
    cell = @board.dig(row, column)
    return false if cell.nil? || !cell.strip.empty?

    @board[row][column] = @player_to_play ? "X" : "O"

    true
  end

  private

  def initialize_board
    @board = Array.new(3) { Array.new(3, " ") }
    @player_to_play = rand > 0.5
  end

  def winner?
    if winning?("X")
      announce_winner("X")
      return true
    elsif winning?("O")
      announce_winner("O")
      return true
    end

    false
  end

  def tie?
    if @board.all? { |row| row.all? { |cell| !cell.strip.empty? } }
      print_board
      puts "The game was a tie!"
      return true
    end

    false
  end

  def winning?(char)
    [check_diagonal(char), check_vertical(char), check_horizontal(char)].any? { |e| e }
  end

  def check_diagonal(char)
    (@board.dig(0, 0) == char && @board.dig(1, 1) == char && @board.dig(2, 2) == char) ||
      (@board.dig(2, 0) == char && @board.dig(1, 1) == char && @board.dig(0, 2) == char)
  end

  def check_vertical(char)
    win = false
    (0...@board[0].length).each do |column|
      cells = (0...@board.length).each.map { |index| @board.dig(index, column) }
      win = true if cells.all? { |cell| cell == char }
      break if win
    end
    win
  end

  def check_horizontal(char)
    win = false
    @board.each do |row|
      win = true if row.all? { |cell| cell == char }
      break if win
    end
    win
  end

  def announce_winner(char)
    print_board
    if char == "X"
      puts "Congratulations, you won!"
    elsif char == "O"
      puts "The computer beat you this time!"
    else
      puts "I don't know who won.."
    end
  end
end

game = TicTacToe.new
game.start_game
