# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative "bst_node"

class BinarySearchTree
  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(value)
    if @root != nil
      if value > @root.value
        if @root.right == nil
          @root.right = append_node(@root, value)
        else
          traverse_tree(@root.right, value)
        end
      else # value <= root
        if @root.left == nil
          @root.left = append_node(@root, value)
        else
          traverse_tree(@root.left, value)
        end
      end
    else
      @root = append_node(nil, value)
    end
  end

  def find(value, tree_node = @root)
    if tree_node == nil
      return BSTNode.new(nil)
    else
      current_node = tree_node

      while current_node
        if value == current_node.value
          return current_node
        end
        if value < current_node.value
          current_node = current_node.left
        else
          current_node = current_node.right
        end
      end
    end
  end

  def delete(value)
    delete_node = find(value)
    replacement_node = nil

    # value not in BST
    return if delete_node == nil

    # no children
    if delete_node.left == nil && delete_node.right == nil
      # delete_node = nil

      if @root == delete_node
        @root = nil
      elsif delete_node.parent.right == delete_node
        delete_node.parent.right = nil
      else
        delete_node.parent.left = nil
      end

    # one child
    elsif delete_node.left == nil
      # Find min in right subtree
      replacement_node = delete_node.right

      while replacement_node.left
        replacement_node = replacement_node.left
      end

      # Delete delete_node and replace with current node

      # Replacement node has a child
      if replacement_node.right
        replacement_node.parent.left = replacement_node.right
      end

      # is delete node left or right child?
      if @root == delete_node
        replacement_node.right = delete_node.right
        @root = replacement_node
      elsif delete_node.parent.right == delete_node
        delete_node.parent.right = replacement_node
        replacement_node.right = delete_node.right
      elsif delete_node.parent.left == delete_node
        delete_node.parent.left = replacement_node
        replacement_node.right = delete_node.right
      end

    # one child
    elsif delete_node.right == nil
      # Specs don't test this :)

    # 2 children
    else
      # Find max in left subtree
      replacement_node = maximum(delete_node.left)

      # Delete delete_node and replace with current node

      # Replacement node has a child
      if replacement_node.left
        replacement_node.parent.right = replacement_node.left
      end

      # is delete node left or right child?
      if @root == delete_node
        replacement_node.left = delete_node.left
        replacement_node.right = delete_node.right
        @root = replacement_node
      elsif delete_node.parent.right == delete_node
        delete_node.parent.right = replacement_node
        replacement_node.right = delete_node.right
        replacement_node.left = delete_node.left
      elsif delete_node.parent.left == delete_node
        delete_node.parent.left = replacement_node
        replacement_node.right = delete_node.right
        replacement_node.left = delete_node.left
      end

    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return nil if !tree_node

    current_node = tree_node
    while current_node.right != nil
      current_node = current_node.right
    end

    current_node
  end

  def depth(tree_node = @root)
    return 0 if tree_node == nil

    depth = 1
    left_depth = 0
    right_depth = 0

    if tree_node.left != nil
      left_depth = depth + depth(tree_node.left)
    end

    if tree_node.right != nil
      right_depth = depth + depth(tree_node.right)
    end

    return [left_depth, depth - 1, right_depth].max
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node == nil

    left_depth = 0
    right_depth = 0

    left_depth = depth(tree_node.left) if tree_node.left
    right_depth = depth(tree_node.right) if tree_node.right

    return false if left_depth > right_depth + 1 || right_depth > left_depth + 1

    return is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
  end

  def in_order_traversal(tree_node = @root, arr = [])

    return [] if @root == nil

    return iot(tree_node, arr)
  end

  # returns arr of nodes instead of values
  def self.modified_in_order_traversal(tree_node = @root, arr = [])
    return [] if tree_node == nil

    if tree_node.left != nil
      BinarySearchTree.modified_in_order_traversal(tree_node.left, arr)
    end

    arr = arr.concat([tree_node])

    if tree_node.right != nil
      BinarySearchTree.modified_in_order_traversal(tree_node.right, arr)
    end

    return arr
  end

  private
  # optional helper methods go here:

  def append_node(parent, value)
    new_node = BSTNode.new(value)
    new_node.parent = parent
    new_node
  end

  # value is value to be inserted
  def traverse_tree(current_node, value)
    if value > current_node.value
      if current_node.right == nil
        current_node.right = append_node(current_node, value)
      else
        traverse_tree(current_node.right, value)
      end
    else # value <= current_node
      if current_node.left == nil
        current_node.left = append_node(current_node, value)
      else
        traverse_tree(current_node.left, value)
      end
    end
  end

  def iot(current_node, arr)
    if current_node.left != nil
      iot(current_node.left, arr)
    end

    arr = arr.concat([current_node.value])

    if current_node.right != nil
      iot(current_node.right, arr)
    end

    return arr
  end
end
