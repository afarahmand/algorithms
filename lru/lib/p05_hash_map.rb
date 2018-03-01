require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    if @store[bucket(key)].include?(key)
      @store[bucket(key)].update(key, val)
    else
      if @count == num_buckets
        resize!
      end
      @store[bucket(key)].append(key, val)
      @count+=1
    end
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    if @store[bucket(key)].include?(key)
      @store[bucket(key)].remove(key)
      @count-=1
    end
  end

  def each
    @store.each do |ll|
      ll.each { |link| yield [link.key, link.val] }
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets*2) { LinkedList.new }
    @store.each do |ll|
      if !ll.empty?
        ll.each do |node|
          new_store[node.key.hash % (num_buckets*2)].append(node.key, node.val)
        end
      end
    end

    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    # p (key.hash % num_buckets)
    key.hash % num_buckets
  end
end
