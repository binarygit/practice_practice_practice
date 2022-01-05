#!/usr/bin/ruby

module Iterator
  private

  def postorder_iterator(node = root, &block)
    return if node.nil?

    postorder_iterator(node.left, &block)
    postorder_iterator(node.right, &block)
    yield(node)
  end

  def preorder_iterator(node = root, &block)
    return if node.nil?

    yield(node)
    preorder_iterator(node.left, &block)
    preorder_iterator(node.right, &block)
  end

  def inorder_iterator(node = root, &block)
    return if node.nil?

    inorder_iterator(node.left, &block)
    yield(node)
    inorder_iterator(node.right, &block)
  end

  def level_order_iterator
    queue = [root]
    until queue.empty?
      node = queue.shift
      yield(node)
      queue << node.left
      queue << node.right
      queue.compact!
    end
  end

  # have checked this works flawlessly!
  def recursive_level_order_iterator(queue = [@root], &block)
    queue.compact!
    return if queue.empty?

    node = queue.shift
    yield(node)
    queue << node.left
    queue << node.right
    recursive_level_order_iterator(queue, &block)
  end
end

# Alternate Implementations

# def postorder_iterator(node = root)
#  return if node.nil?

#  [postorder_iterator(node.left), postorder_iterator(node.right), node].compact.flatten
# end

# def inorder_iterator(node = root)
#  return if node.nil?

#  nodes = []
#  l_node = inorder_iterator(node.left)
#  r_node = inorder_iterator(node.right)
#  (nodes << l_node) unless l_node.nil?
#  nodes << node
#  (nodes << r_node) unless r_node.nil?
#  nodes.flatten
# end

# def preorder_iterator(node = root)
#   return if node.nil?

#   [node, preorder_iterator(node.left), preorder_iterator(node.right)].compact.flatten
# end

# def inorder_iterator(node = root)
#   return if node.nil?

#   [inorder_iterator(node.left), node, inorder_iterator(node.right)].compact.flatten
# end
