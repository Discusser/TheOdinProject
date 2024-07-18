require_relative "node"

class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = @head
  end

  def append(value)
    if @tail.nil?
      @tail = Node.new(value)
      @head = @tail
    else
      @tail.next_node = Node.new(value)
      @tail = @tail.next_node
    end
  end

  def prepend(value)
    if @head.nil?
      @head = Node.new(value)
      @tail = @head
    else
      new_head = Node.new(value)
      new_head.next_node = @head
      @head = new_head
    end
  end

  def size
    i = 0
    current = @head
    until current.nil?
      current = current.next_node
      i += 1
    end
    i
  end

  def at(index)
    i = 0
    current = @head
    until i == index || current.nil?
      current = current.next_node
      i += 1
    end
    current
  end

  def pop
    size = self.size
    return if size.zero?

    second_to_last = at(size - 2)
    @tail = second_to_last
    second_to_last.next_node = nil
  end

  def shift
    @head = @head.next_node
  end

  def contains?(value)
    current = @head
    until current.nil?
      return true if current.value == value

      current = current.next_node
    end
    false
  end

  def find(value)
    i = 0
    current = @head
    until current.nil?
      return i if current.value == value

      current = current.next_node
      i += 1
    end
    nil
  end

  def to_s
    output = ""
    current = @head
    until current.nil?
      output << current.to_s << " -> "
      current = current.next_node
    end
    output << "nil"
    output
  end

  def insert_at(value, index)
    size = self.size
    return if index > size
    return append(value) if index == size
    return prepend(value) if index.zero?

    new_node = Node.new(value)
    before = at(index - 1)
    after = at(index)
    before.next_node = new_node
    # rubocop:disable UselessSetterCall
    new_node.next_node = after
    # rubocop:enable UselessSetterCall
  end

  def remove_at(index)
    size = self.size
    return if index >= size
    return pop if index == size - 1
    return shift if index == 0

    before = at(index - 1)
    after = at(index + 1)
    before.next_node = after
  end
end

list = LinkedList.new
list.append("dog")
list.append("cat")
list.append("parrot")
list.append("hamster")
list.append("snake")
list.append("turtle")
