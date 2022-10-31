class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    if include?(key)
      return
    else
      bucket = self[key]
      bucket << key
      @count += 1
    end
  end

  def include?(key)
    bucket = self[key]
    i = 0
    while i < bucket.length
      return true if bucket[i] == key
      i += 1
    end
    false
  end

  def remove(key)
    if include?(key)
      bucket = self[key]
      bucket.delete(key)
      @count -= 1
    else
      return
    end
  end

  private

  attr_accessor :store

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    k = num.hash
    @store[k % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |ele|
        new_store[ele % (num_buckets * 2)] << ele
      end
    end
    self.store = new_store
  end
end
