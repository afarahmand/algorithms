class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc
    @store = []
  end

  def count
    @store.length
  end

  def extract
    @store.pop if count < 3
    @store[0], @store[count-1] = @store[count-1], @store[0]
    BinaryMinHeap.heapify_down(@store, 0, count - 1, &@prc) if count > 1
    @store.pop
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    len = @store.length
    BinaryMinHeap.heapify_up(@store, len-1, len, &@prc) if len > 1
  end

  public
  def self.child_indices(len, parent_index)
    child_indices = []
    first_child_idx = (2*parent_index+1)
    child_indices << first_child_idx if first_child_idx < len
    child_indices << (first_child_idx + 1) if (first_child_idx + 1) < len
    child_indices
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index-1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    # p array[0..len]
    # p array
    child_indices = BinaryMinHeap.child_indices(len, parent_idx)
    prc ||= Proc.new { |x,y| x <=> y }

    # if no children, return array
    if child_indices != []
      min_child_idx = nil
      if child_indices.length == 1
        min_child_idx = child_indices.pop
      else
        # if array[child_indices[0]] > array[child_indices[1]]
        if prc.call(array[child_indices[1]], array[child_indices[0]]) == -1
          min_child_idx = child_indices[1]
        else
          min_child_idx = child_indices[0]
        end
      end

      # if array[min_child_idx] < array[parent_idx]
      if prc.call(array[min_child_idx], array[parent_idx]) == -1
        array[parent_idx], array[min_child_idx] = array[min_child_idx], array[parent_idx]
        BinaryMinHeap.heapify_down(array, min_child_idx, len, &prc)
      end
    else
      return array
    end
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    # p array
    prc ||= Proc.new {|x,y| x <=> y}
    parent_idx = BinaryMinHeap.parent_index(child_idx)

    if prc.call(array[child_idx], array[parent_idx]) == -1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      BinaryMinHeap.heapify_up(array, parent_idx, len, &prc) if parent_idx != 0
    end

    return array
  end
end
