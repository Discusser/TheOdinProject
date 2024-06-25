module Colors
  COLORS = Hash.new("  ").update({
                                   0 => "🔴",
                                   1 => "🟢",
                                   2 => "🔵",
                                   3 => "🟡",
                                   4 => "🟤",
                                   5 => "🟠",
                                   6 => "⚫",
                                   7 => "⚪"
                                 }).freeze

  def self.index_valid?(index)
    index.is_a?(Integer) && index.between?(0, COLORS.length - 1)
  end

  def self.indices_to_strings(indices)
    indices.map { |index| COLORS[index] }
  end
end
