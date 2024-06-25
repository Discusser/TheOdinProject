module Colors
  INDEX_TO_STRING = {
    -1 => "  ",
    0 => "🔴",
    1 => "🟢",
    2 => "🔵",
    3 => "🟡",
    4 => "🟤",
    5 => "🟠",
    6 => "⚫",
    7 => "⚪"
  }.freeze

  def self.index_valid?(index)
    index.is_a?(Integer) && index.between?(0, 7)
  end

  def self.index_to_string(index)
    INDEX_TO_STRING[index]
  end

  def self.indices_to_strings(indices)
    indices.map { |index| index_to_string(index) }
  end
end
