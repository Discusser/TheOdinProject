class Guess
  attr_reader :colors, :correct_pos_and_color, :correct_color

  def initialize(guess, secret_code)
    @colors = Array.new(Mastermind::COLUMNS, -1) if guess.nil?
    return if guess.nil? || secret_code.nil?

    @colors = guess
    @correct_pos_and_color = 0
    @correct_color = 0
    check_colors(secret_code)
  end

  def check_colors(secret_code)
    @colors.each_index do |index|
      if @colors[index] == secret_code[index]
        @correct_pos_and_color += 1
      elsif secret_code.include?(@colors[index])
        @correct_color += 1
      end
    end
  end

  def valid_colors?
    colors.all? { |e| Colors.index_valid?(e) }
  end

  def to_s
    Colors.indices_to_strings(colors).join
  end
end
