require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    p to_s
    # Key in cache
    if @map.include?(key)
      # move node in list to beg of LL
      node = @store[key]

      next_node = node.next
      prev_node = node.prev
      prev_node.next = next_node
      next_node.prev = prev_node

      head = @store.first.prev
      node.prev = head
      node.next = head.next

    else # Key not in cache
      if @max == count
        # Remove LRU element
        @store.remove(key)
        @map.delete(key)
      end

      # Append new key
      val = @prc.call(key)
      new_node = @store.append(key, val)
      @map[key] = new_node
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
  end
end
