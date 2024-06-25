class GuessInformation
  attr_reader :correct_pos_and_color, :correct_color

  def initialize(correct_pos_and_color, correct_color)
    @correct_pos_and_color = correct_pos_and_color
    @correct_color = correct_color
  end

  def self.from_guess(guess, secret_code)
    correct_pos_and_color = 0
    correct_color = 0

    guess.each_index do |index|
      if guess[index] == secret_code[index]
        correct_pos_and_color += 1
      elsif secret_code.include?(guess[index])
        correct_color += 1
      end
    end

    GuessInformation.new(correct_pos_and_color, correct_color)
  end
end
