#!/usr/bin/ruby
require 'pry-byebug'

class Graph
  attr_reader :vertices, :edge_list, :adj_m, :adj_list, :bfs_info, :bfs_node

  def initialize(vertices, edge_list)
    @vertices = vertices
    @edge_list = edge_list
    @adj_m = Array.new(vertices) { Array.new(vertices) { 0 } }
    @adj_list = Array.new(vertices) { Array.new }
  end

  def bfs(source)
    create_adj_list
    @bfs_info = Array.new(vertices) { { distance: nil, pred: nil } }
    bfs_info[source][:distance] = 0
    queue = [bfs_info[source]]

    loop do
      break if queue.empty?

      @pred = queue.shift
      vertex = index(@pred)
      adj_list[vertex].each do |e|
        @bfs_node = bfs_info[e]
        if bfs_node[:distance].nil?
          set_dis_and_pred
          queue << bfs_node
        end
      end
    end
    bfs_info
  end

  def create_adj_m
    edge_list.each do |a, b|
      replace(a, b)
    end
    adj_m
  end

  def create_adj_list
    edge_list.each do |a, b|
      adj_list[a].push(b)
    end
    adj_list
  end

  private

  def set_dis_and_pred
    bfs_node[:distance] = @pred[:distance].succ
    bfs_node[:pred] = index(@pred)
  end

  def index(elem)
    @bfs_info.each_with_index do |item, idx|
      return idx if elem.equal?(item)
    end
  end

  def replace(idx, second_idx)
    adj_m[idx].insert(second_idx, 1)
    adj_m[idx].delete_at(second_idx + 1)
  end
end

m = Graph.new(6, [[0, 2], [1, 3], [2, 3], [2, 4], [3, 5], [4, 5]])
m.bfs(2)
