class Fixnum
  # Fixnum#hash already implemented for you
end

class Array

  def hash
    array = self.drop(1)
    array.inject(1){|accumulator, element| element.object_id * accumulator}
  end

end

class String

  def hash
    idx = 0
    hash = 0
    while idx < size
      hash += (self[idx].ord * idx)
      idx +=1
    end
    hash
  end
end

class Hash
  def hash
    self.keys.inject(1) do |acc, key|
      acc * (key.to_s.ord + self[key].to_s.ord)
    end
  end
end
