class Board
  def initialize
    @board = Array.new(3) { Array.new(3, " ") }
  end

  def display
    print " " * (@board.length.to_s.length + 2)
    (0...@board[0].length).each do |index|
      print "#{index + 1} "
    end
    puts
    @board.each_with_index do |row, index|
      puts "#{index + 1} [#{row.join(',')}]"
    end
  end

  def put(row, column, character)
    cell = @board.dig(row, column)
    return false if cell.nil? || !cell.strip.empty?

    @board[row][column] = character

    true
  end

  def winning?(player)
    char = player.character
    [check_diagonal(char), check_vertical(char), check_horizontal(char)].any? { |e| e }
  end

  def tie?
    if @board.all? { |row| row.all? { |cell| !cell.strip.empty? } }
      display
      puts "The game was a tie!"
      return true
    end

    false
  end

  private

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
end
