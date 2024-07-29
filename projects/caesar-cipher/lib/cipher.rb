def caesar_cipher(string, shift_factor)
  string.chars.map do |character|
    shifted_ordinal = character.ord

    lowercase = ("a".."z").include?(character)
    uppercase = ("A".."Z").include?(character)
    if lowercase || uppercase
      shifted_ordinal = (character.ord + shift_factor)
      shifted_ordinal -= 26 while shifted_ordinal > (lowercase ? "z" : "Z").ord
    end

    shifted_ordinal.chr
  end.join
end

p caesar_cipher("What a string!", 5)
