class Player
  attr_reader :character

  def initialize(character)
    @character = character
  end

  def make_move() end
end

class HumanPlayer < Player
  def make_move
    print "Specify row and column to play, separated by a space: "
    response = gets.chomp.split.map(&:to_i)
    return make_move unless response.length == 2 && response.all? { |e| e.is_a?(Integer) && e.positive? }

    response.map { |e| e - 1 }
  end
end

class ComputerPlayer < Player
  def make_move
    [rand(0..2), rand(0..2)]
  end
end
