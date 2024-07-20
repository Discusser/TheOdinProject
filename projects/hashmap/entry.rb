class Entry
  attr_accessor :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end

  def to_a
    [key, value]
  end

  def to_s
    "[ #{key}, #{value} ]"
  end
end
