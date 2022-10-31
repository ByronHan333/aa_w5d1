
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    prev_node = @prev
    next_node = @next
    prev_node.next = next_node
    next_node.prev = prev_node
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new(nil, nil)
    @tail = Node.new(nil, nil)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node = @head.next
    until node == @tail
      return node.val if node.key == key
      node = node.next
    end
    nil
  end

  def include?(key)
    node = @head.next
    until node == @tail
      return true if node.key == key
      node = node.next
    end
    false
  end

  def append(key, val)
    last_node = @tail.prev
    node = Node.new(key, val)
    last_node.next = node
    node.prev = last_node
    node.next = @tail
    @tail.prev = node
  end

  def update(key, val)
    node = @head.next
    until node == @tail
      node.val = val if node.key == key
      node = node.next
    end
  end

  def remove(key)
    node = @head.next
    until node == @tail
      if node.key == key
        node.remove
        return
      end
      node = node.next
    end
  end

  def each(&prc)
    current_node = @head.next
    until current_node == @tail
      prc.call(current_node)
      current_node= current_node.next
    end
      
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
    