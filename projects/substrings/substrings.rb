def substrings(string, dictionary)
  dictionary.reduce(Hash.new(0)) do |hash, element|
    occurences = string.downcase.scan(element)
    hash[element] += occurences.length unless occurences.length == 0
    hash
  end
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("below", dictionary)
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
