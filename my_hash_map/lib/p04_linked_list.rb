require 'byebug'

class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
   include Enumerable
  attr_reader :head

  def initialize
    @head = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
  end

  def last
    current_link = head
    until current_link.next.nil?
      current_link = current_link.next
    end
    current_link
  end

  def empty?
  end

  def get(key)
    self.each do |current_link|
       return current_link.val if current_link.key == key
     end
  end

  def include?(key)
    each {|link| return true if link.key == key}
    false
  end

  def insert(key, val)
    link = Link.new(key, val)
    last.next = link
  end

  def remove(key)
    self.each do |current_link|
      if current_link.next.key == key
        current_link.next = current_link.next.next
        return current_link.next
      end
    end
  end

  def each(&prc)
    current_link = head
    until current_link.nil?
      # debugger
      prc.call(current_link)
      current_link = current_link.next
    end
  end
end
