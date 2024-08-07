require_relative "node"

# rubocop:disable Metrics/ClassLength
class Tree
  attr_reader :root

  def initialize(array)
    @root = build_tree(array.sort.uniq)
  end

  def build_tree(sorted_array, array_start = 0, array_end = sorted_array.length - 1)
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
      node_to_modify = current.data > value ? current.left : current.right
      if node_to_modify.nil?
        current.data > value ? current.left = Node.new(value) : current.right = Node.new(value)
        break
      else
        current = node_to_modify
      end
    end
  end

  # Deletes a node
  def delete_node(node)
    return if node.nil?

    if node.leaf?
      # Handle leaf deletion
      delete_leaf(node)
    elsif node.children.length == 1
      # Handle single child deletion
      delete_single_child_node(node)
    else
      # Handle two child deletion
      delete_two_child_node(node)
    end
  end

  # Deletes a node with a given value
  def delete(value)
    delete_node(find(value))
  end

  def preorder(root = @root, &block)
    return [] if root.nil?

    visited = []

    visited << (block_given? ? yield(root) : root.data)
    visited.concat(preorder(root.left, &block))
    visited.concat(preorder(root.right, &block))

    visited
  end

  def inorder(root = @root, &block)
    return [] if root.nil?

    visited = []

    visited.concat(inorder(root.left, &block))
    visited << (block_given? ? yield(root) : root.data)
    visited.concat(inorder(root.right, &block))

    visited
  end

  def postorder(root = @root, &block)
    return [] if root.nil?

    visited = []

    visited.concat(postorder(root.left, &block))
    visited.concat(postorder(root.right, &block))
    visited << (block_given? ? yield(root) : root.data)

    visited
  end

  # Finds a node's parent such that the node has a given value
  def find_parent(value, root = @root)
    return nil if root.nil?

    return root if [root.left&.data, root.right&.data].include?(value)
    return find_parent(value, root.left) if value < root.data

    find_parent(value, root.right) if value > root.data
  end

  # Finds a node with a given value
  def find(value, root = @root)
    return nil if root.nil?

    return find(value, root.left) if value < root.data
    return find(value, root.right) if value > root.data

    root if value == root.data
  end

  def height(root = @root)
    return 0 if root.nil? || root.leaf?

    1 + [height(root.left), height(root.right)].max
  end

  def depth(node, root = @root)
    return 0 if node.nil? || root == node

    return 1 + depth(node, root.left) if node.data < root.data

    1 + depth(node, root.right)
  end

  def level_order(root = @root)
    queue = [root]

    until queue.empty?
      root = queue.shift
      yield(root)
      queue << root.left unless root.left.nil?
      queue << root.right unless root.right.nil?
    end
  end

  def balanced?
    (height(@root.left) - height(@root.right)).abs <= 1
  end

  def rebalance
    @root = build_tree(inorder)
  end

  # rubocop:disable Style/OptionalBooleanParameter
  def pretty_print(node = @root, prefix = "", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
  # rubocop:enable Style/OptionalBooleanParameter

  private

  def delete_leaf(node)
    parent = find_parent(node.value)
    if parent.left&.data == node.value
      parent.left = nil
    else
      parent.right = nil
    end
  end

  def delete_single_child_node(node)
    if node.left.nil?
      node.from!(node.right)
    elsif node.right.nil?
      node.from!(node.left)
    end
  end

  def delete_two_child_node(node)
    traversal = inorder { |n| n }
    index = traversal.index(node)
    # the biggest node will never have two children, so we know that the successor exists in a balanced tree
    successor = traversal[index + 1]
    temp = successor.data
    delete_node(successor)
    node.data = temp
  end
end
# rubocop:enable Metrics/ClassLength

tree = Tree.new((Array.new(15) { rand(1..100) }))
tree.insert(150)
tree.insert(135)
tree.insert(195)
tree.insert(180)
tree.pretty_print
tree.rebalance
tree.pretty_print
p tree.balanced?
