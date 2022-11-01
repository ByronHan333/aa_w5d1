require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    linked_list = bucket(key)
    linked_list.include?(key)
  end

  def set(key, val)
    resize! if @count == num_buckets
    linked_list = bucket(key)
    if linked_list.include?(key)
      linked_list.update(key, val)
    else
      linked_list.append(key, val)
      @count += 1
    end
  end

  def get(key)
    linked_list = bucket(key)
    linked_list.get(key)
  end

  def delete(key)
    linked_list = bucket(key)
    linked_list.remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |linked_list|
      linked_list.each do |node|
        prc.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { LinkedList.new }
    @store.each do |linked_list|
      # head = linked_list.first
      linked_list.each do |node|
        idx = node.key.hash % (num_buckets * 2)
        new_linked_list = new_store[idx]
        new_linked_list.append(node.key, node.val)
      end
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end

  def inspect
    res = []
    @store.each do |b|
      b.each {|el| res << el} 
    end
    res
  end
end
