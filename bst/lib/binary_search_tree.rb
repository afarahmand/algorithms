# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative "bst_node"

class BinarySearchTree
  attr_reader :root

  def initialize
  end

  def insert(value)
  end

  def find(value, tree_node = @root)
  end

  def delete(value)
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
  end

  def depth(tree_node = @root)
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end

  # returns arr of nodes instead of values
  def self.modified_in_order_traversal(tree_node = @root, arr = [])
  end

  private
  # optional helper methods go here:
end
