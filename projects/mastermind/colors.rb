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

  def self.string_to_indices(string, columns)
    indices = string.split.map { |e| e.to_i - 1 }
    return nil if indices.length != columns || !indices.all? do |e|
                    Colors.index_valid?(e)
                  end || indices.uniq.length != indices.length

    indices
  end
end
