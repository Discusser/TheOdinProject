module Strategy
  module Base
    def make_guess(previous_guesses, columns) end
  end

  class Manual
    include Base

    def make_guess(_previous_guesses, columns)
      guess = []
      loop do
        print "Make a guess with #{columns} unique space separated digits: "
        next if (guess = Colors.string_to_indices(gets.chomp, columns)).nil?

        break
      end
      guess
    end
  end

  # This strategy wins in an average of 660 moves (tested for 50 different games), and has a theoretical maximum move
  # count of Colors::COLORS.length.pow(Mastermind::COLUMNS), which is 8**4 = 4096 with default settings. Each game
  # took on average 275.7 ms for 50 games
  class Random
    include Base

    def make_guess(previous_guesses, columns)
      guess = []
      loop do
        # Only make unique guesses
        guess = (0...Colors::COLORS.length).to_a.sample(columns)
        break if previous_guesses.none? { |e| e.colors == guess }
      end
      guess
    end
  end

  # This strategy wins in an average of 6.017 moves (tested for 1000 different games), and runs infinitely faster than
  # Strategy::Random. For 1000 games, each game took an average of 2.32 ms
  class Swaszek
    include Base

    def initialize(columns)
      @possible_guesses = (0...Colors::COLORS.length).to_a.permutation(columns).to_a
    end

    def make_guess(previous_guesses, _columns)
      return @possible_guesses.sample if previous_guesses.empty?

      response = previous_guesses.first
      @possible_guesses.delete(response.colors)
      next_guess = @possible_guesses.sample
      # Delete all possible guesses that wouldn't have given the same response if they were the secret code
      @possible_guesses.delete_if do |secret_code|
        guess = Guess.new(response.colors, secret_code)
        guess.correct_pos_and_color != response.correct_pos_and_color || guess.correct_color != response.correct_color
      end

      next_guess
    end
  end
end
