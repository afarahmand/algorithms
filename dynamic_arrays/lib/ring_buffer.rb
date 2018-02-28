require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @start_idx = 0
    @store = StaticArray.new(0)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[adj_index(index)]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[adj_index(index)]=val
  end

  # O(1)
  def pop
    check_index(0)
    popped_value = @store[adj_index(@length-1)]
    @length-=1

    popped_value
  end

  # O(1) ammortized
  def push(val)
    if @length == @capacity
      resize!
    end

    @store[adj_index(@length)] = val
    @length+=1
  end

  # O(1)
  def shift
    check_index(0)
    shifted_value = @store[adj_index(0)]
    @length-=1
    @start_idx+=1

    shifted_value
  end

  # O(1) ammortized
  def unshift(val)
    if @length == @capacity
      resize!
    end

    @start_idx == 0 ? @start_idx = @capacity-1 : @start_idx-=1
    @store[@start_idx] = val
    @length+=1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def adj_index(index)
    ((index + @start_idx) % @capacity)
  end

  def check_index(index)
    if @length == 0 || index >= @length
      raise "index out of bounds"
    end
  end

  def resize!
    new_store = StaticArray.new(@capacity*2)
    i = 0
    while i < @length
      new_store[i] = @store[adj_index(i)]
      i+=1
    end
    @store = new_store
    @start_idx = 0
    @capacity = @capacity*2
  end
end
