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
    json = JSON.dump({
                       selected_word: @selected_word,
                       guesses_left: @guesses_left,
                       letters_guessed: @letters_guessed
                     })
    print "Enter a name for your save file: "
    filename = gets.chomp
    File.write("saves/#{filename}.json", json)

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

  def list_saves
    available_saves = Dir.children("saves").select do |file|
      File.file?(File.join("saves", file)) && file.end_with?(".json")
    end
    available_saves.map { |file| file.split(".").first }
  end

  def prompt_for_save_to_load
    available_saves = list_saves.join(", ")
    loop do
      print "Which save would you like to load? (#{available_saves}): "
      input = "#{gets.chomp}.json"
      path = File.join("saves", input)
      next unless File.exist?(path)

      return load_save(path)
    end
  end

  def load_save(path)
    data = JSON.parse(File.read(path))
    p data
    @selected_word = data["selected_word"]
    @guesses_left = data["guesses_left"]
    @letters_guessed = data["letters_guessed"]
  end

  def try_load_save
    print "Would you like to load a save? (y/n) "
    loop do
      input = gets.chomp
      return if input == "n"
      break if input == "y"
    end

    prompt_for_save_to_load
  end

  def start_game
    try_load_save

    while @guesses_left.positive?
      next_guess

      @guesses_left -= 1

      break if won?
    end

    display_end_message
  end
end

Hangman.new
