#!/usr/bin/ruby
require 'pry-byebug'

class Board
  attr_reader :squares, :edge_list, :bfs_info, :pred, :bfs_node, :adj_list

  def initialize
    @squares = create_squares
    @edge_list = create_edge_list
    @adj_list = create_adj_list
  end

  def do_bfs(source)
    queue = [initialize_bfs_info(source)]

    until queue.empty?

      @pred = queue.shift
      vertex = index
      adj_list[vertex].each do |e|
        @bfs_node = bfs_info[e]
        (set_values; queue.push(bfs_node)) if bfs_node[:distance].nil?
      end
    end
    bfs_info
  end

  def sq_to_idx(sqr)
    squares.index(sqr)
  end

  def idx_to_sqr(idx)
    squares[idx]
  end

  private

  def create_squares
    squares = []
    8.times do |y|
      8.times do |x|
        squares << [x, y]
      end
    end
    squares
  end

  def create_edge_list
    edge_list = []
    @squares.each_with_index do |(x, y), index|
      get_potential_edges(x, y).each do |e|
        idx = squares.index(e)
        edge_list << [index, idx] if idx
      end
    end
    edge_list
  end

  def create_adj_list
    adj_list = Array.new(64) { [] }
    edge_list.each do |a, b|
      adj_list[a].push(b)
    end
    adj_list
  end

  def get_potential_edges(x, y)
    [[x + 2, y + 1], [x - 2, y - 1], [x + 2, y - 1], [x - 2, y + 1],
     [x + 1, y + 2], [x - 1, y - 2], [x + 1, y - 2],
     [x - 1, y + 2]]
  end

  def initialize_bfs_info(source)
    source = squares.index(source)
    @bfs_info = Array.new(64) { { distance: nil, pred: nil } }
    bfs_info[source][:distance] = 0
    bfs_info[source]
  end

  def set_values
    bfs_node[:distance] = pred[:distance].succ
    bfs_node[:pred] = index
  end

  def index
    bfs_info.each_with_index do |item, idx|
      return idx if pred.equal?(item)
    end
  end
end

class Knight
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def move(start, finish)
    bfs_info = board.do_bfs(start)
    finish = board.sq_to_idx(finish)
    move_list = [finish]
    queue = [bfs_info[finish]]
    until queue.empty?
      node = queue.shift
      next_node = bfs_info[node[:pred]]
      move_list.push(node[:pred])
      queue.push(next_node) unless node[:distance] == 1
    end
    puts "You got there in #{move_list.length - 1} moves "
    move_list.reverse_each { |i| p board.idx_to_sqr(i) }
  end
end

k = Knight.new
k.move([0, 0], [1, 2])
puts
puts
k.move([0, 0], [3, 3])
puts
k.move([3, 3], [4, 3])
