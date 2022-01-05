#!/usr/bin/ruby
require 'pry-byebug'
require_relative 'iterator'

class Node
  include Comparable
  attr_accessor :left, :right
  attr_reader :value

  def <=>(other)
    value <=> other.value
  end

  def initialize(value)
    @value = value
  end

  def leaf_node?
    right.nil? && left.nil?
  end

  def single_parent?
    right.nil? || left.nil?
  end
end

class Tree
  include Iterator
  attr_reader :arr, :root, :to_del

  def initialize(arr)
    @arr = arr.uniq.sort
    @root = nil
  end

  def build
    center = arr.size / 2
    left = arr[0, center]
    right = arr[center.succ..-1]

    @root = Node.new(arr[center])
    root.left = Tree.new(left).build unless left.empty?
    root.right = Tree.new(right).build unless right.empty?

    root
  end

  def level_order(&block)
    if block_given?
      recursive_level_order_iterator(&block)
    else
      values = []
      level_order { |node| values << node.value }
      values
    end
  end

  def inorder(root = @root, &block)
    if block_given?
      inorder_iterator(root) { |node| block.call(node) }
    else
      values = []
      inorder_iterator(root) { |node| values << node.value }
      values
    end
  end

  def preorder(&block)
    if block_given?
      preorder_iterator(&block)
    else
      values = []
      preorder_iterator { |node| values << node.value }
      values
    end
  end

  def postorder(&block)
    if block_given?
      postorder_iterator(&block)
    else
      values = []
      postorder_iterator { |node| values << node.value }
      values
    end
  end

  def find(value)
    inorder { |node| return node if node.value.eql?(value) }
  end

  def insert(value, root = @root)
    if root.left.nil? && value < root.value
      root.left = Node.new(value)
    elsif root.right.nil? && value > root.value
      root.right = Node.new(value)
    else
      insert(value, root.left) if value < root.value

      insert(value, root.right) if value > root.value
    end
  end

  def delete(value)
    return nil if find(value).nil?

    @to_del = find(value)
    node = find(value)
    return delete_leaf_node if node.leaf_node?
    return delete_single_parent if node.single_parent?

    # node with two children
    #
    # Here, building a new tree without the current root
    # is equivalent to finding the inorder succ and then
    # replacing it with current root (node with value)
    new_root = Tree.new(inorder(node).reject { |i| i == node.value }).build
    change_child(parent_node(node), new_root)
  end

  def depth(node, root = @root)
    depth = 0
    loop do
      break if node.equal?(root)

      node = parent_node(node)
      depth += 1
    end
    depth
  end

  def balanced?(node = root)
    return true if node.nil? || node.leaf_node?

    height = (height(node.left) - height(node.right)).abs
    return balanced?(node.left) && balanced?(node.right) if height <= 1

    false
  end

  def rebalance
    return self if balanced?

    array = inorder.uniq
    n_tree = Tree.new(array)
    @root = n_tree.build
  end

  private

  def height(node)
    return 0 if node.nil? || node.leaf_node?

    leaf_nodes = []
    inorder(node) { |n| leaf_nodes << n if n.leaf_node? }
    possible_heights = []
    leaf_nodes.each { |n| possible_heights << depth(n, node) }
    possible_heights.max
  end

  def change_child(p_node, new_child = nil)
    return (@root = new_child) if to_del.equal?(@root)
    return (p_node.left = new_child) if p_node.left.eql?(to_del)

    p_node.right = new_child
  end

  def delete_single_parent
    child = to_del.left || to_del.right
    change_child(parent_node(to_del), child)
  end

  def delete_leaf_node
    change_child(parent_node(to_del))
  end

  def parent_node(child_node)
    inorder { |node| return node if node.left.eql?(child_node) || node.right.eql?(child_node) }
  end
end

# alternative implementations

## Here delete and insert create a completely new balanced tree
## rather than disbalancing the existing tree

# def delete(value)
#  return nil if find(value).nil?

#  values = inorder.select { |item| item != value }
#  @root = Tree.new(values).build
# end

# def insert(value)
#   values = inorder
#   values << value
#   @root = Tree.new(values).build
# end

# def postorder(&block)
#  if block_given?
#    postorder_iterator.each { |node| block.call(node) }
#  else
#    values = []
#    postorder_iterator.each { |node| values << node.value }
#    values
#  end
# end
