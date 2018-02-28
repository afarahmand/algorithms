# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store#, :max

  def initialize
    @store = RingBuffer.new
    # @max = RingBuffer.new
  end

  def enqueue(val)
    @store.push(val)
  end

  def dequeue
    @store.shift
  end

  def max
    max_val = @store[0]
    i = 1
    while i < @store.length
      max_val = @store[i] if @store[i] > max_val
      i+=1
    end

    max_val
  end

  def length
    @store.length
  end

end
