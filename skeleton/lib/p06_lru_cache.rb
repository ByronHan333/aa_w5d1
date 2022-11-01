require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'rspec'
require 'byebug'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    # debugger
    if @map.include?(key)
      current_node = @map[key]
      update_node!(current_node)
      return current_node.val
    else
      eject! if self.count == @max
      current_node = calc!(key)
      @map[key] = current_node
      return current_node.val
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    node = Node.new(key, val)

    last_node = @store.last
    tail = last_node.next

    tail.prev = node
    node.next = tail

    last_node.next = node
    node.prev = last_node
    return node
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
      prev_node = node.prev
      next_node = node.next 
      prev_node.next = next_node
      next_node.prev = prev_node

      last_node = @store.last
      tail = last_node.next

      last_node.next = node
      node.next = tail
      tail.prev = node
      node.prev = last_node
  end

  def eject!
    first_node = @store.first
    first_node.remove
    @map.delete(first_node.key)
  end
end

prc = Proc.new {|i| i*2}
lru = LRUCache.new(3, prc)


3.times do
  1.upto(3) { |i| lru.get(i) }
end


