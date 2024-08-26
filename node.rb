require 'colorize'

class Node
  attr_accessor :value, :next_node

  def initialize value = nil, next_node = nil
    @value = value
    @next_node = next_node
  end
end


class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end

  def append value
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
    else
      current = @head
      current = current.next_node until current.next_node.nil?
      current.next_node = new_node
    end
  end

  def prepend value
    new_node = Node.new(value, @head)
    @head = new_node
  end

  def size
    count = 0
    current = @head
    while current
      count += 1
      current = current.next_node
    end
    count
  end

  def head
    @head
  end

  def tail
    current = @head
    current = current.next_node until current.next_node.nil?
    current
  end

  def at index
    current = @head
    index.times do
      return "Element #{index} is not found" if current.nil?
      current = current.next_node
    end
    current.nil? ? "Element #{index} is not found" : current.value
  end

  def pop
    return if @head.nil?
    if @head.next_node.nil?
      @head = nil
    else
      current = @head
      current = current.next_node until current.next_node.next_node.nil?
      current.next_node = nil
    end
  end

  def contains? value
    current = @head
    while current
      return true if current.value == value
      current = current.next_node
    end
    false
  end

  def find value
    index = 0
    current = @head
    while current
      return index if current.value == value
      current = current.next_node
      index += 1
    end
    "Element #{value} not found"
  end

  def insert_at value, index
    return if index < 0
    if index == 0
      prepend(value)
      return
    end
    current = @head
    (index - 1).times do
      return if current.nil?
      current = current.next_node
    end
    return if current.nil?
    new_node = Node.new(value, current.next_node)
    current.next_node = new_node
  end

  def remove_at index
    return if index < 0
    if index == 0
      @head = @head.next_node
      return
    end
    current = @head
    (index - 1).times do
      return if current.nil?
      current = current.next_node
    end
    return if current.nil? || current.next_node.nil?
    current.next_node = current.next_node.next_node
  end

  def to_s
    return "nil" if @head.nil?
    full_list = []
    current = @head
    while current
      full_list << "( #{current.value} )"
      current = current.next_node
    end
    full_list.join(" -> ") + " -> nil"
  end

end


# Initialize a new LinkedList instance
list = LinkedList.new

# Test prepend method
list.prepend(2)
list.prepend('Hello')
list.append(5)

# Test to_s method to display the list
puts "Linked List after prepend and append operations:".colorize(:blue)
puts list.to_s # Expected: ( Hello ) -> ( 2 ) -> ( 5 ) -> nil

# Test head method
puts "Head value:".colorize(:blue)
puts list.head.value # Expected: 'Hello'

# Test size method
puts "Size of list:".colorize(:blue)
puts list.size # Expected: 3

# Test tail method
puts "Tail value:".colorize(:blue)
puts list.tail.value # Expected: 5

# Test at method
puts "Element at index 0:".colorize(:blue)
puts list.at(0) # Expected: 'Hello'
puts "Element at index 1:".colorize(:blue)
puts list.at(1) # Expected: 2
puts "Element at index 2:".colorize(:blue)
puts list.at(2) # Expected: 5
puts "Element at index 3:".colorize(:blue)
puts list.at(3) # Expected: "Element 3 is not found"

# Test pop method
list.pop
puts "Linked List after pop operation:".colorize(:blue)
puts list.to_s # Expected: ( Hello ) -> ( 2 ) -> nil

# Test contains? method
puts "List contains 'Hello'?".colorize(:blue)
puts list.contains?('Hello') # Expected: true
puts "List contains 5?".colorize(:blue)
puts list.contains?(5) # Expected: false

# Test find method
puts "Index of 'Hello':".colorize(:blue)
puts list.find('Hello') # Expected: 0
puts "Index of 2:".colorize(:blue)
puts list.find(2) # Expected: 1
puts "Index of 5:".colorize(:blue)
puts list.find(5) # Expected: "Element 5 not found"

# Test insert_at method
list.insert_at(10, 1)
puts "Linked List after inserting 10 at index 1:".colorize(:blue)
puts list.to_s # Expected: ( Hello ) -> ( 10 ) -> ( 2 ) -> nil

# Test remove_at method
list.remove_at(1)
puts "Linked List after removing element at index 1:".colorize(:blue)
puts list.to_s # Expected: ( Hello ) -> ( 2 ) -> nil
