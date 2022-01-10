#!/usr/bin/ruby
require_relative 'myenum'
require 'pry-byebug'

class LinkedList
  include MyEnumerable
  attr_reader :head

  def initialize
    @head = nil
  end

  def append(value)
    node = Node.new(value)
    return @head = node if head.nil?

    tail.next_node = node
  end

  def prepend(value)
    node = Node.new(value)
    return @head = node if head.nil?

    node.next_node = head
    @head = node
  end

  def size
    size = 0
    each { size += 1 }
    size
  end

  def at(index)
    return nil if head.nil?

    each_with_index { |item, idx| return item if idx.eql?(index) }
  end

  def pop
    return nil if head.nil?
    return (popped = head; @head = nil; popped) if size.eql?(1)

    popped = tail
    pred(tail).next_node = nil
    popped
  end

  def contains?(value)
    each { |item| return true if item.value.eql?(value) }
    false
  end

  def find(value)
    each { |item| return index(item) if item.value.eql?(value) }
  end

  def insert_at(index, value)
    return unless valid?(index)
    return prepend(value) if index.eql?(0)
    return append(value) if index.eql?(index(tail))

    pred(at(index)).next_node = Node.new(value, pred(at(index)).next_node)
  end

  def remove_at(index)
    return unless valid?(index)
    return pop if index.eql?(index(tail))
    return shift if index.zero?

    pred(at(index)).next_node = at(index).next_node
  end

  def tail
    return nil if head.nil?

    select { |node| node.next_node.nil? }[0]
  end

  def to_s
    return 'No items in list' if head.nil?

    str = ''
    each { |item| str += "( #{item.value} ) -> " }
    str + 'nil'
  end

  def uniq
    special_each_with_index do |node, idx|
      next if node.equal?(head)

      if pred(node).value.eql?(node.value)
        remove_at(idx)
      end
    end
    self
  end

  private

  def shift
    return nil if head.nil?
    return (shifted = head; @head = nil; shifted) if size.eql?(1)

    current_head = head
    @head = head.next_node
    current_head
  end

  def pred(node)
    each_with_index { |item, idx| return item if idx.eql?(index(node).pred) }
  end

  def index(node)
    each_with_index { |item, idx| return idx if item == node }
  end

  def valid?(index)
    0 <= index && index <= size - 1
  end
end

class Node
  attr_reader :value
  attr_accessor :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end
