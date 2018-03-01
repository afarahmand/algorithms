class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    prev = @prev
    @prev.next = @next
    @next.prev = prev
    # optional but useful, connects previous node to next node
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new()
    @tail = Node.new()
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    if empty?
      return nil
    else
      return @head.next
    end
  end

  def last
    if empty?
      return nil
    else
      return @tail.prev
    end
  end

  def empty?
    return true if @head.next == @tail
    false
  end

  def get(key)
    current_node = @head.next
    until current_node == @tail
      return current_node.val if current_node.key == key
      current_node = current_node.next
    end

    return nil
  end

  def include?(key)
    current_node = @head.next
    until current_node == @tail
      return true if current_node.key == key
      current_node = current_node.next
    end

    return false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.next = @tail
    new_node.prev = @tail.prev
    @tail.prev.next = new_node
    @tail.prev = new_node
    new_node
  end

  def update(key, val)
    current_node = @head.next
    until current_node == @tail
      if current_node.key == key
        current_node.val = val
        break
      end
      current_node = current_node.next
    end
  end

  def remove(key)
    current_node = @head.next
    until current_node == @tail
      if current_node.key == key
        current_node.remove
        break
      end
      current_node = current_node.next
    end
  end

  def each
    current_node = @head.next
    until current_node == @tail
      yield current_node
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
