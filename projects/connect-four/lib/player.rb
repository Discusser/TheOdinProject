class Player
  attr_reader :character

  def initialize(character)
    @character = character
  end

  def make_move(board)
    print "Choose a column #{character}: "
    input = gets.chomp
    is_integer = Integer(input, exception: false).instance_of?(Integer)
    return make_move(board) unless is_integer

    input = input.to_i - 1
    in_bounds = input.between?(0, board.columns - 1)
    return make_move(board) unless in_bounds

    input
  end
end
