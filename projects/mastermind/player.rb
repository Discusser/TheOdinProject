module Player
  def wait_for_guess(previous_guesses, columns) end
end

class HumanPlayer
  include Player
  def wait_for_guess(_previous_guesses, columns)
    guess = []
    loop do
      print "Make a guess with #{columns} space separated digits: "
      guess = gets.chomp.split.map { |e| e.to_i - 1 }
      next if guess.length != columns || !guess.all? { |e| Colors.index_valid?(e) }

      break
    end
    guess
  end
end

class ComputerPlayer
  include Player
end
