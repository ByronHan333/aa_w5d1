class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    hash_value = 0
    self.each_with_index do |v , i|
      hash_value += (v + i ** 2).to_s.ord
    end
    hash_value
  end
end

class String
  def hash
    hash_value = 0
    self.each_char.with_index do |v , i|
      hash_value += (v.to_s.ord * i.to_s.ord ** 2)
    end
    hash_value
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_value = 0
    self.each_pair do |v , i|
      hash_value += (v.to_s.ord * i.to_s.ord)
    end
    hash_value
  end
end
