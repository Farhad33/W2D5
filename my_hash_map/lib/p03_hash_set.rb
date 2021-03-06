require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
    unless self[num % num_buckets].include?(key)
      self[num % num_buckets] << key
      @count += 1
    end
    resize! if @count == @store.length
  end

  def remove(key)
    num = key.hash
    self[num % num_buckets].delete(key)
  end

  def include?(key)
    num = key.hash
    self[num % num_buckets].any? {|element| element == key }
  end

  private

  def [](key)
    @store[key]
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


  # def insert(key)
  # end
  #
  # def include?(key)
  # end
  #
  # def remove(key)
  # end
  #
  # private
  #
  # def [](num)
  #   # optional but useful; return the bucket corresponding to `num`
  # end
  #
  # def num_buckets
  #   @store.length
  # end
  #
  # def resize!
  # end
end
