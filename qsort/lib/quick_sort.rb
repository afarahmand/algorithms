class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.nil? || array.length < 2

    pivot = array[0]
    left = QuickSort.sort1(array[1..-1].select{ |el| el < pivot })
    right = QuickSort.sort1(array[1..-1].select{ |el| el >= pivot })

    return left.concat([pivot]).concat(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return if length - start < 2
    prc ||= Proc.new { |x,y| x <=> y }
    pivot = array[start]
    swap_idx = start+1

    i = start+1
    while i < start + length
      # p "--------"
      # p array
      # print "pivot:", pivot, "|i:", i, "|len:", length
      # print " swap_idx:" + swap_idx.to_s
      # p ""

      # if array[i] < pivot
      if prc.call(array[i], pivot) == -1
        if swap_idx != i
          array[i], array[swap_idx] = array[swap_idx], array[i]
        end
        swap_idx+=1
      end
      i+=1
    end

    # p array[start]
    # p array[swap_idx-1]
    # array[start],array[swap_idx-1] = array[start],array[swap_idx-1]
    temp = array[start]
    array[start] = array[swap_idx-1]
    array[swap_idx - 1] = temp

    # p start
    # p swap_idx
    # p pivot

    # p swap_idx
    # sleep(1)

    print "1: "
    p array
    QuickSort.sort2!(array, start, swap_idx - start, &prc)
    print "2: "
    p array
    QuickSort.sort2!(array, swap_idx+1-start, array.length - swap_idx + 1 - start, &prc)
    print "3: "
    p array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x,y| x <=> y }
    pivot = array[start]
    swap_idx = start+1

    i = start+1
    while i < start + length

      # if array[i] < pivot
      if prc.call(array[i], pivot) == -1
        if swap_idx != i
          array[i], array[swap_idx] = array[swap_idx], array[i]
        end
        swap_idx+=1
      end
      i+=1
    end

    array[start], array[swap_idx-1] = array[start], array[swap_idx-1]

    return swap_idx-1
  end
end
