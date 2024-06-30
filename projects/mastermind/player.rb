require_relative "colors"
require_relative "strategy"

module Player
  attr_reader :strategy

  def wait_for_guess(previous_guesses, columns)
    @strategy.make_guess(previous_guesses, columns)
  end

  def win_message(moves) end
  def lose_message() end
  def make_secret_code(color_choices, length) end
end

class HumanPlayer
  include Player

  def initialize(strategy = Strategy::Manual.new)
    @strategy = strategy
  end

  def win_message(moves)
    puts "You won in #{moves} moves!"
  end

  def lose_message
    puts "You lost! Better luck next time!"
  end

  def make_secret_code(_color_choices, length)
    (0...Colors::COLORS.length).to_a.sample(length)
  end
end

class ComputerPlayer
  include Player

  def initialize(strategy = Strategy::Random.new)
    @strategy = strategy
  end

  def win_message(moves)
    puts "The computer won in #{moves} moves!"
  end

  def lose_message
    puts "The computer lost this time!"
  end

  def make_secret_code(color_choices, length)
    puts color_choices
    secret_code = []
    loop do
      print "Enter your secret code as a sequence of #{length} unique space separated digits: "
      next if (secret_code = Colors.string_to_indices(gets.chomp, length)).nil?

      break
    end
    secret_code
  end
end
