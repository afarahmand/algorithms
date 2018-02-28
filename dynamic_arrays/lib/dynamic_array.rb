require_relative "static_array"

# capacity full size
# length fake size

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @store = StaticArray.new(0)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index]=value
  end

  # O(1)
  def pop
    check_index(0)
    popped_value = @store[@length-1]
    @length-=1
    popped_value
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length == @capacity
      resize!
    end

    @store[@length] = val
    @length+=1
  end

  # O(n): has to shift over all the elements.
  def shift
    check_index(0)
    shifted_value = @store[0]
    @length-=1
    i = 0
    while i < @length
      @store[i] = @store[i+1]
      i+=1
    end

    shifted_value
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if @length == @capacity
      resize!
    end

    i = @length
    while i > 0
      @store[i] = @store[i-1]
      i-=1
    end

    @store[0] = val
    @length+=1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    if @length == 0 || index >= @length
      raise "index out of bounds"
    end
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @store = StaticArray.new(@capacity*2)
    @capacity = @capacity*2
  end
end
