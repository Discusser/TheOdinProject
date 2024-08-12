require_relative "display"
require_relative "player_colors"
require_relative "player"
require_relative "board"

COLUMNS = 7
ROWS = 6

class Controller
  def initialize
    @board = Board.new(ROWS, COLUMNS)
    @display = Display.new(@board)
    @current_player_index = 0
    @players = [Player.new(RED), Player.new(BLUE)]
  end

  def play_turn
    player = @players[@current_player_index]
    loop do
      move = player.make_move(@board)
      break if @board.add_token(move, player.character)
    end

    @display.print_board
    @current_player_index = (@current_player_index + 1) % @players.length

    play_turn unless game_over?
  end

  def start_game
    @display.print_board
    play_turn

    if board_full?
      puts "Nobody won!"
    else
      winner = find_winner
      puts "Player #{winner} won!"
    end
  end

  def game_over?
    return true if board_full?

    !find_winner.nil?
  end

  def board_full?
    @board.board.flatten.all? { |cell| !cell.empty? }
  end

  def find_winner
    [find_horizontal_winner, find_vertical_or_diagonal_winner].compact[0]
  end

  private

  # rubocop:disable Metrics/MethodLength
  def find_horizontal_winner
    @board.board.each_with_index do |row, row_index|
      row.each_with_index do |token, column_index|
        next if token.empty?

        return token if positions_match([
                                          [row_index, column_index],
                                          [row_index, column_index - 1],
                                          [row_index, column_index - 2],
                                          [row_index, column_index - 3]
                                        ], token)
      end
    end

    nil
  end

  def find_vertical_or_diagonal_winner
    @board.board.each_with_index do |row, row_index|
      row.each_with_index do |token, column_index|
        next if token.empty?

        (-1..1).each do |multiplier|
          next unless positions_match([
                                        [row_index, column_index],
                                        [row_index - 1, column_index + (1 * multiplier)],
                                        [row_index - 2, column_index + (2 * multiplier)],
                                        [row_index - 3, column_index + (3 * multiplier)]
                                      ], token)

          return token
        end
      end
    end

    nil
  end
  # rubocop:enable Metrics/MethodLength

  def positions_match(positions, token)
    positions.all? do |pos|
      return false if pos[0].negative? || pos[1].negative?

      @board.board.dig(pos[0], pos[1]) == token
    end
  end
end
