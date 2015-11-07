class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)

    validate!(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    (0...@store.length).include?(num)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    unless self[num_buckets(num)].include?(num)
      self[num_buckets(num)] << num
    end
  end

  def remove(num)
    self[num_buckets(num)].delete(num)
  end

  def include?(num)
    self[num_buckets(num)].any? {|element| element == num }
  end

  private

  def [](num)
    @store[num]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets(num)
    num % @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self[num % num_buckets].include?(num)
      self[num % num_buckets] << num
      @count += 1
    end
    resize! if @count == @store.length
  end

  def remove(num)
    self[num % num_buckets].delete(num)
  end

  def include?(num)
    self[num % num_buckets].any? {|element| element == num }
  end

  private

  def [](num)
    @store[num]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_array = @store
    @store = Array.new(count * 2) {Array.new}
    @count = 0
    old_array.each do |bucket|
      bucket.each do |num|
        insert(num)
      end
    end
  end
end
