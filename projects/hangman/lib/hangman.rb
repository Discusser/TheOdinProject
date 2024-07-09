require "json"

class Hangman
  def initialize
    @selected_word = select_random_word
    @guesses_left = 10
    @letters_guessed = [@selected_word[0].upcase]

    start_game
  end

  def select_random_word
    words = File.readlines("words")
    loop do
      word = words.sample.strip
      return word if word.size.between?(5, 12)
    end
  end

  def save_game
    p JSON.dump({
                  selected_word: @selected_word,
                  guesses_left: @guesses_left,
                  letters_guessed: @letters_guessed
                })
    exit(0)
  end

  def wait_for_input
    loop do
      print "You have already used #{@letters_guessed.join(', ')}. " unless @letters_guessed.empty?
      print "Pick a new letter (type SAVE to save): "
      letter = gets.chomp.upcase
      return save_game if letter == "SAVE"

      if letter.size == 1 && letter.match?(/[[:alpha:]]/) && !@letters_guessed.include?(letter)
        @letters_guessed.push(letter)
        return letter
      end
    end
  end

  def display_guesses
    @selected_word.chars.each do |char|
      print @letters_guessed.include?(char.upcase) ? char : "_"
      print " "
    end
    puts
  end

  def won?
    @selected_word.chars.all? { |char| @letters_guessed.include?(char.upcase) }
  end

  def display_end_message
    if won?
      puts "You found the word!"
    else
      puts "You lost! Better luck next time!"
    end
    puts "The word was #{@selected_word}"
  end

  def next_guess
    display_guesses
    puts "You have #{@guesses_left} #{@guesses_left == 1 ? 'guess' : 'guesses'} left."
    wait_for_input
  end

  def start_game
    while @guesses_left.positive?
      next_guess

      @guesses_left -= 1

      break if won?
    end

    display_end_message
  end
end

Hangman.new
