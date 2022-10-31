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
    idx = num % 20
    @store[idx] << num
  end

  def remove(num)
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
  end

  def remove(num)
  end

  def include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
  end
end
