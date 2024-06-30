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

  class Random
    include Base

    def make_guess(previous_guesses, columns)
      guess = []
      loop do
        # Only make unique guesses
        break unless previous_guesses.include?(guess = (0...Colors::COLORS.length).to_a.sample(columns))
      end
      guess
    end
  end
end
