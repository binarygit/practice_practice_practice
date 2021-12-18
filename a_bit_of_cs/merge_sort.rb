#!/usr/bin/ruby
require 'pry-byebug'

class MergeSort
  def sort(array)
    return array if array.size.eql?(1) || array.empty?
    sorted_array = []
    divisor = array.size/2

    left_array = array[0, divisor]
    right_array = array[divisor..-1]

    left_array = sort(left_array)
    right_array = sort(right_array)

    i = 0
    j = 0
    loop do
      (sorted_array.push(right_array[i..-1]); break) if left_array.size.eql?(j)
      (sorted_array.push(left_array[j..-1]); break) if right_array.size.eql?(i)
      (sorted_array.push(left_array[j]); j += 1; next) if left_array[j] < right_array[i]
      sorted_array.push(right_array[i])
      i += 1
    end

    sorted_array.flatten
  end
end

