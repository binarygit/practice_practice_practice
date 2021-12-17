#!/usr/bin/ruby
require 'pry-byebug'

class MergeSort
  def sort(array)
    return array if array.size.eql?(1) || array.empty?
  end
end
