#!/usr/bin/ruby

module MyEnumerable
  def each_with_index(&block)
    return if head.nil?

    node = head
    i = 0
    loop do
      block.call(node, i)
      break if node.next_node.nil?

      node = node.next_node
      i += 1
    end
  end

  def special_each_with_index(&block)
    return if head.nil?

    node = head
    loop do
      block.call(node, index(node))
      break if node.next_node.nil?

      node = node.next_node
    end
  end

  def each(&block)
    return if head.nil?

    node = head
    loop do
      block.call(node)
      break if node.next_node.nil?

      node = node.next_node
    end
  end

  def select(&block)
    selected = []
    each do |node|
      selected << node if block.call(node)
    end
    selected
  end
end
