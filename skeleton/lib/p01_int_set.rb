class MaxIntSet
    attr_reader :max, :store
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    raise "Out of bounds" if is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num > max || num < 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = self[num]
    bucket << num
  end

  def remove(num)
    bucket = self[num]
    bucket.delete(num)
  end

  def include?(num)
    bucket = self[num]
    i = 0 
    while i < bucket.length
      return true if bucket[i] == num
      i += 1
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    return @store[num % 20]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets
    bucket = self[num]
    i = 0
    while i < bucket.length
      return if bucket[i] == num
      i+=1
    end
    bucket << num 
    @count += 1
  end

  def remove(num)
    bucket = self[num]
    if bucket.delete(num)
      @count -= 1
    end
  end

  def include?(num)
    bucket = self[num]
    i = 0
    while i < bucket.length
      return true if bucket[i] == num
      i+=1
    end
    false
  end

  def num_buckets
    @store.length
  end

  private

  attr_accessor :store

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    return @store[num % num_buckets]
  end

  # def num_buckets
  #   @store.length
  # end

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

set = ResizingIntSet.new 
p set.num_buckets
puts 
21.times { |i| set.insert(i) }
p set.num_buckets