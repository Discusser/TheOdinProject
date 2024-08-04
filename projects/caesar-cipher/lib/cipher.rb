class CaesarCipher
  attr_accessor :message, :shift_factor

  def initialize(message, shift_factor)
    @message = message
    @shift_factor = shift_factor
  end

  def shift_string
    @message.chars.map { |character| shift_character(character, @shift_factor) }.join
  end

  private

  def shift_value(value, shift_factor, min, max)
    range = max - min + 1
    shifted_value = value + shift_factor
    shifted_value -= range while shifted_value > max
    shifted_value += range while shifted_value < min
    shifted_value
  end

  def shift_character(character, shift_factor)
    shifted_ordinal = character.ord

    lowercase = ("a".."z").include?(character)
    uppercase = ("A".."Z").include?(character)
    if lowercase
      shifted_ordinal = shift_value(shifted_ordinal, shift_factor, "a".ord, "z".ord)
    elsif uppercase
      shifted_ordinal = shift_value(shifted_ordinal, shift_factor, "A".ord, "Z".ord)
    end

    shifted_ordinal.chr
  end
end
