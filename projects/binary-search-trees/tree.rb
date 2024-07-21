require_relative "node"

class Tree
  attr_reader :root

  def initialize(array)
    @root = build_tree(array.sort.uniq)
    pretty_print
  end

  def build_tree(sorted_array, array_start = 0, array_end = sorted_array.length)
    return nil if array_start > array_end

    middle = (array_start + array_end) / 2
    root = Node.new(sorted_array[middle])

    root.left = build_tree(sorted_array, array_start, middle - 1)
    root.right = build_tree(sorted_array, middle + 1, array_end)

    root
  end

  def insert(value)
    current = @root
    loop do
      node_to_modify = current.value > value ? current.left : current.right
      if node_to_modify.nil?
        current.value > value ? current.left = Node.new(value) : current.right = Node.new(value)
        break
      else
        current = node_to_modify
      end
    end
  end

  def pretty_print(node = @root, prefix = "", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.insert(2)
tree.pretty_print
