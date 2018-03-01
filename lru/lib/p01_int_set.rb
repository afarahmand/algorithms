class MaxIntSet
  def initialize(max)
    @store = Array.new(max)
  end

  def insert(num)
    @store[num]=true if is_valid?(num)
  end

  def remove(num)
    @store[num]=false if is_valid?(num)
  end

  def include?(num)
    @store[num] if is_valid?(num)
  end

  private

  def is_valid?(num)
    if(num < 0 || num >= @store.length)
      raise "Out of bounds"
    end

    return true
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num].push(num) if !include?(num)
  end

  def remove(num)
    self[num].delete(num) if include?(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
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
    if !include?(num)
      resize! if @count == num_buckets
      self[num].push(num)
      @count+=1
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count-=1
    end
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets*2) { Array.new }
    @store.each do |bucket|
      if !bucket.empty?
        bucket.each do |num|
          new_store[num % (num_buckets*2)].push(num)
        end
      end
    end

    @store = new_store
  end
end
