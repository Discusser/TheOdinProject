require_relative "../linked-list/linked_list"
require_relative "entry"

class HashMap
  attr_reader :buckets, :load_factor

  def initialize
    @buckets = Array.new(16) { nil }
    @load_factor = 0.75
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end

  def set(key, value)
    grow_buckets(@buckets.size * 2) if length >= @load_factor * @buckets.size

    index = key_to_index(key)
    @buckets[index] = LinkedList.new if @buckets[index].nil?
    remove(key) if has?(key)
    @buckets[index].append(Entry.new(key, value))
  end

  def get(key)
    bucket = @buckets[key_to_index(key)]
    return nil if bucket.nil?

    node = bucket.at(bucket.find { |entry| entry.key == key })
    return nil if node.nil?

    node.value.value
  end

  def has?(key)
    !get(key).nil?
  end

  def remove(key)
    return nil? unless has?(key)

    bucket = @buckets[key_to_index(key)]
    entry = get(key)
    bucket.remove_at(bucket.find { |entry| entry.key == key })
    entry
  end

  def length
    @buckets.compact.inject(0) { |sum, list| sum + list.size }
  end

  def clear
    @buckets = Array.new(@buckets.size) { nil }
  end

  def keys
    entries.map { |entry| entry.key }
  end

  def values
    entries.map { |entry| entry.value }
  end

  def entries
    @buckets.compact.map { |list| list.to_a }.flatten
  end

  private

  def key_to_index(key)
    hash(key) % @buckets.length
  end

  def grow_buckets(new_size)
    entries = self.entries
    @buckets = Array.new(new_size) { nil }
    entries.each { |entry| set(entry.key, entry.value) }
  end
end

test = HashMap.new
test.set("apple", "red")
test.set("banana", "yellow")
test.set("carrot", "orange")
test.set("dog", "brown")
test.set("elephant", "gray")
test.set("frog", "green")
test.set("grape", "purple")
test.set("hat", "black")
test.set("ice cream", "white")
test.set("jacket", "blue")
test.set("kite", "pink")
test.set("lion", "golden")
pp test.entries
