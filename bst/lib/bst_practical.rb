require_relative "binary_search_tree"

def kth_largest(tree_node, k)
  all_nodes_in_order = BinarySearchTree.modified_in_order_traversal(tree_node)
  return all_nodes_in_order[-k]
end
