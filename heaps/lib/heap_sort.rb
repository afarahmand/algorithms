require_relative "heap"

class Array
  def heap_sort!
    heaped_idx = 1
    prc = Proc.new {|x,y| x <=> y}

    # Makes array into a heap with root at idx 0
    while heaped_idx < self.length
      i = 0
      while i < heaped_idx
        BinaryMinHeap.heapify_up(self, heaped_idx, heaped_idx+1, &prc)
        i+=1
      end
      heaped_idx+=1
    end

    i = 1
    while i < self.length
      # print "i: "
      # p i
      # print "Length: "
      # p self.length-i
      # print "Item to be swapped: "
      # p self[self.length-i]
      # swap
      self[self.length-i], self[0] = self[0], self[self.length-i]

      BinaryMinHeap.heapify_down(self, 0, self.length-i, &prc)
      #   def self.heapify_down(array, parent_idx, len = array.length, &prc)
      i+=1
    end

    # p "Sorted: "
    # p self.reverse!
    self.reverse!
  end
end
