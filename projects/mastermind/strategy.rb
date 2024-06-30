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
  # count of Colors::COLORS.length.pow(Mastermind::COLUMNS), which is 8**4 = 4096 with default settings
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
end
