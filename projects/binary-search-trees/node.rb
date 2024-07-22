class Node
  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def from!(other)
    @data = other.data
    @left = other.left
    @right = other.right
  end

  def leaf?
    @left.nil? && @right.nil?
  end

  def children
    [@left, @right].compact
  end
end
